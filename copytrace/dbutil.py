# dbutil.py
#
# Util functions to interact with the moves/copy database
#
# Copyright 2015 Facebook, Inc.
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2 or any later version.


from mercurial import scmutil, util, commands
import bundle2
import sqlite3


localdb = 'moves.db'
remotedb = 'moves.db'  # Will be modified to the XDB database


def _sqlcmds(name, remote):
    """
    returns a sql command for the given name and remote (MySQL or sqlite)
    """

    if name == 'tableexists':
        return "SELECT name " + \
               "FROM sqlite_master " + \
               "WHERE type='table' AND name='Moves';"

    elif name == 'createtable':
        return 'CREATE TABLE Moves(' + \
                    'repo CHAR(64) NOT NULL, ' + \
                    'hash CHAR(40) NOT NULL, ' + \
                    'source TEXT, ' + \
                    'destination TEXT, ' + \
                    'mv CHAR(1) NOT NULL ' + \
                    ');'

    elif name == 'insertctx':
        return 'INSERT INTO Moves VALUES (?, ?, ?, ?, ?);'

    elif name == 'retrievemoves':
        return 'SELECT DISTINCT hash, source, destination ' + \
               'FROM Moves ' + \
               'WHERE hash IN (%s) AND mv = %s AND repo = %s;'

    elif name == 'retrieveraw':
        return 'SELECT DISTINCT hash, source, destination, mv ' + \
               'FROM Moves ' + \
               'WHERE hash IN (%s) and repo = %s;'

    elif name == 'retrievehashes':
        return 'SELECT DISTINCT hash ' + \
               'FROM Moves ' + \
               'WHERE hash IN (%s);'

    elif name == 'deletectx':
        return 'DELETE FROM Moves ' + \
               'WHERE hash = ? AND repo = ?;'


def _connect(repo, remote):
    if remote:
        dbname = remotedb
    else:
        dbname = localdb

    try:
        conn = sqlite3.connect(repo.vfs.join(dbname))
        cursor = conn.cursor()
    except:
        raise util.Abort('could not reach the local %s database' % dbname)

    _exists(cursor, remote)
    return dbname, conn, cursor


def _close(conn, cursor):
    cursor.close()
    conn.close()


def _exists(cursor, remote):
    """
    checks the existence of the Moves table and creates it if it doesn't
    """
    try:
        cursor.execute(_sqlcmds('tableexists', remote))
        table = cursor.fetchall()
        if not table:
            cursor.execute(_sqlcmds('createtable', remote))
    except:
        raise util.Abort('could not create the %s Moves table ' %
                         'remote' if remote else 'local')


def insertitem(cursor, ctxhash, dic, move, remote, repo):
    """
    inserts {dst:src} in the database using the cursor
    """
    mv = '1' if move else '0'
    insertcmd = _sqlcmds('insertctx', remote)

    # No rename in this ctx
    if dic == {}:
        insertdata = (repo.root, ctxhash, None, None, mv)
        cursor.execute(insertcmd, insertdata)

    else:
        for dst, src in dic.iteritems():
            insertdata = (repo.root, ctxhash, src, dst, mv)
            cursor.execute(insertcmd, insertdata)


def insertdata(repo, ctx, mvdict, cpdict, remote=False):
    """
    inserts the mvdict/cpdict = {dst: src} data in the database with '1' if it
    is a move, '0' if it is a copy
    """
    dbname, conn, cursor = _connect(repo, remote)

    # '0'is used as temp data storage
    if ctx == '0':
        ctxhash = '0'
    else:
        ctxhash = str(ctx.hex())
    try:
        insertitem(cursor, ctxhash, mvdict, True, remote, repo)
        insertitem(cursor, ctxhash, cpdict, False, remote, repo)
        conn.commit()
    except:
        raise util.Abort('could not insert data into the %s database' % dbname)

    _close(conn, cursor)


def insertrawdata(repo, dic, remote=False):
    """
    inserts dict = {ctxhash: [src, dst, mv]} for moves and copies into the
    database
    """
    dbname, conn, cursor = _connect(repo, remote)
    try:
        for ctxhash, mvlist in dic.iteritems():
            for src, dst, mv in mvlist:
                if src == 'None' and dst == 'None':
                    src = None
                    dst = None
                insertdata = (repo.root, ctxhash, src, dst, mv)
                cursor.execute(_sqlcmds('insertctx', remote), insertdata)
        conn.commit()
    except:
        raise util.Abort('could not insert data into the %s database' % dbname)

    _close(conn, cursor)


def retrievedatapkg(repo, ctxlist, move=False, remote=False, askserver=True):
    """
    retrieves {ctxhash: {dst: src}} for ctxhash in ctxlist for moves or copies
    """
    # Do we want moves or copies
    mv = '1' if move else '0'

    dbname, conn, cursor = _connect(repo, remote)
    try:
        # Returns : hash, src, dst
        cursor.execute(_sqlcmds('retrievemoves', remote)
                      % (','.join(['?'] * len(ctxlist)), '?', '?'),
                      ctxlist + [mv, repo.root])
    except:
        raise util.Abort('could not access data from the %s database' % dbname)

    all_rows = cursor.fetchall()
    _close(conn, cursor)

    ret = {}
    # Building the mvdict and cpdict for each ctxhash:
    for ctxhash, src, dst in all_rows:
        # No move or No copy
        if not dst:
            ret.setdefault(ctxhash.encode('utf8'), {})
        else:
            ret.setdefault(ctxhash.encode('utf8'), {})[dst.encode('utf8')] = \
                 src.encode('utf8')

    processed = ret.keys()
    missing = [f for f in ctxlist if f not in processed]

    # The local database doesn't have the data for this ctx and hasn't tried
    # to retrieve it yet (firstcheck)
    if askserver and not remote and missing:
        _requestdata(repo, missing)
        add = retrievedatapkg(repo, missing, move=move, remote=remote,
                              askserver=False)
        ret.update(add)

    return ret


def retrieverawdata(repo, ctxlist, remote=False, askserver=True):
    """
    retrieves {ctxhash: [src, dst, mv]} for ctxhash in ctxlist for moves or
    copies
    """
    dbname, conn, cursor = _connect(repo, remote)
    try:
        # Returns: hash, src, dst, mv
        cursor.execute(_sqlcmds('retrieveraw', remote) %
                       (','.join(['?'] * len(ctxlist)), '?'),
                       ctxlist + [repo.root])
    except:
        raise util.Abort('could not access data from the %s database' % dbname)

    all_rows = cursor.fetchall()
    _close(conn, cursor)

    ret = {}
    # Building the mvdict and cpdict for each ctxhash:
    for ctxhash, src, dst, mv in all_rows:
        # No move or No copy
        if not src and not dst:
            src = 'None'
            dst = 'None'
        ret.setdefault(ctxhash.encode('utf8'), []).append((src.encode('utf8'),
             dst.encode('utf8'), mv.encode('utf8')))

    processed = ret.keys()
    missing = [f for f in ctxlist if f not in processed]

    # The local database doesn't have the data for this ctx and hasn't tried
    # to retrieve it yet (askserver)
    if askserver and not remote and missing:
        _requestdata(repo, missing)
        add = retrieverawdata(repo, missing, move=move, remote=remote,
                              askserver=False)
        ret.update(add)

    return ret


def removectx(repo, ctx, remote=False):
    """
    removes the data concerning the ctx in the database
    """
    dbname, conn, cursor = _connect(repo, remote)
    # '0'is used as temp data storage
    if ctx == '0':
        ctxhash = '0'
    else:
        ctxhash = str(ctx.hex())
    deletedata = [ctxhash, repo.root]
    try:
        cursor.execute(_sqlcmds('deletectx', remote), deletedata)
        conn.commit()
    except:
        raise util.Abort('could not delete ctx from the %s database' % dbname)

    _close(conn, cursor)


def checkpresence(repo, ctxlist):
    """
    checks if the ctx in ctxlist are in the local database or requests for it
    """
    ctxhashs = [ctx.hex() for ctx in ctxlist]
    dbname, conn, cursor = _connect(repo, False)
    try:
        # Returns hash
        cursor.execute(_sqlcmds('retrievehashes', False)
                       % (','.join('?' * len(ctxhashs))),
                       ctxhashs)
    except:
        raise util.Abort('could not check ctx presence in the %s database'
                         % dbname)
    processed = cursor.fetchall()
    _close(conn, cursor)
    processed = [ctx[0].encode('utf8') for ctx in processed]
    missing = [repo[f].node() for f in ctxlist if f not in processed]
    if missing:
        _requestdata(repo, missing)


def _requestdata(repo, nodelist):
    """
    Requests missing ctx data to a server
    """
    try:
        bundle2.pullmoves(repo, nodelist)
    except:
        pass
