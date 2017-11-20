#require serve

  $ hg init test
  $ cd test
  $ echo b > b
  $ hg ci -Am "b"
  adding b
  $ echo a > a
  $ hg ci -Am "first a"
  adding a
  $ hg tag -r 1 a-tag
  $ hg bookmark -r 1 a-bookmark
  $ hg rm a
  $ hg ci -m "del a"
  $ hg branch a-branch
  marked working directory as branch a-branch
  (branches are permanent and global, did you want a bookmark?)
  $ echo b > a
  $ hg ci -Am "second a"
  adding a
  $ hg rm a
  $ hg ci -m "del2 a"
  $ hg mv b c
  $ hg ci -m "mv b"
  $ echo c >> c
  $ hg ci -m "change c"
  $ hg log -p
  changeset:   7:46c1a66bd8fc
  branch:      a-branch
  tag:         tip
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     change c
  
  diff -r c9637d3cc8ef -r 46c1a66bd8fc c
  --- a/c	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,1 +1,2 @@
   b
  +c
  
  changeset:   6:c9637d3cc8ef
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     mv b
  
  diff -r 958bd88be4eb -r c9637d3cc8ef b
  --- a/b	Thu Jan 01 00:00:00 1970 +0000
  +++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,1 +0,0 @@
  -b
  diff -r 958bd88be4eb -r c9637d3cc8ef c
  --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -0,0 +1,1 @@
  +b
  
  changeset:   5:958bd88be4eb
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     del2 a
  
  diff -r 3f41bc784e7e -r 958bd88be4eb a
  --- a/a	Thu Jan 01 00:00:00 1970 +0000
  +++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,1 +0,0 @@
  -b
  
  changeset:   4:3f41bc784e7e
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     second a
  
  diff -r 292258f86fdf -r 3f41bc784e7e a
  --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
  +++ b/a	Thu Jan 01 00:00:00 1970 +0000
  @@ -0,0 +1,1 @@
  +b
  
  changeset:   3:292258f86fdf
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     del a
  
  diff -r 94c9dd5ca9b4 -r 292258f86fdf a
  --- a/a	Thu Jan 01 00:00:00 1970 +0000
  +++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,1 +0,0 @@
  -a
  
  changeset:   2:94c9dd5ca9b4
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     Added tag a-tag for changeset 5ed941583260
  
  diff -r 5ed941583260 -r 94c9dd5ca9b4 .hgtags
  --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
  +++ b/.hgtags	Thu Jan 01 00:00:00 1970 +0000
  @@ -0,0 +1,1 @@
  +5ed941583260248620985524192fdc382ef57c36 a-tag
  
  changeset:   1:5ed941583260
  bookmark:    a-bookmark
  tag:         a-tag
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     first a
  
  diff -r 6563da9dcf87 -r 5ed941583260 a
  --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
  +++ b/a	Thu Jan 01 00:00:00 1970 +0000
  @@ -0,0 +1,1 @@
  +a
  
  changeset:   0:6563da9dcf87
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     b
  
  diff -r 000000000000 -r 6563da9dcf87 b
  --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
  +++ b/b	Thu Jan 01 00:00:00 1970 +0000
  @@ -0,0 +1,1 @@
  +b
  
  $ hg serve -n test -p $HGPORT -d --pid-file=hg.pid -E errors.log
  $ cat hg.pid >> $DAEMON_PIDS

tip - two revisions

  $ (get-with-headers.py localhost:$HGPORT 'log/tip/a')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: a history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/a" title="Atom feed for test:a" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/a" title="RSS feed for test:a" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/tip">log</a></li>
  <li><a href="/graph/tip">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/tip">changeset</a></li>
  <li><a href="/file/tip">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/tip/a">file</a></li>
  <li><a href="/diff/tip/a">diff</a></li>
  <li><a href="/comparison/tip/a">comparison</a></li>
  <li><a href="/annotate/tip/a">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/tip/a">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/a" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log a @ 4:<a href="/rev/3f41bc784e7e">3f41bc784e7e</a>
   <span class="phase">draft</span> <span class="branchname">a-branch</span> 
   
  </h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/tip/a?revcount=30">less</a>
  <a href="/log/tip/a?revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/3f41bc784e7e">second a</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/5ed941583260">first a</a>
     <span class="phase">draft</span> <span class="tag">a-tag</span> <span class="tag">a-bookmark</span> 
    </td>
   </tr>
   
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/tip/a?revcount=30">less</a>
  <a href="/log/tip/a?revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> 
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  

second version - two revisions

  $ (get-with-headers.py localhost:$HGPORT 'log/4/a')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: a history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/a" title="Atom feed for test:a" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/a" title="RSS feed for test:a" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/4">log</a></li>
  <li><a href="/graph/4">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/4">changeset</a></li>
  <li><a href="/file/4">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/4/a">file</a></li>
  <li><a href="/diff/4/a">diff</a></li>
  <li><a href="/comparison/4/a">comparison</a></li>
  <li><a href="/annotate/4/a">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/4/a">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/a" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log a @ 4:<a href="/rev/3f41bc784e7e">3f41bc784e7e</a>
   <span class="phase">draft</span> <span class="branchname">a-branch</span> 
   
  </h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/4/a?revcount=30">less</a>
  <a href="/log/4/a?revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/3f41bc784e7e">second a</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/5ed941583260">first a</a>
     <span class="phase">draft</span> <span class="tag">a-tag</span> <span class="tag">a-bookmark</span> 
    </td>
   </tr>
   
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/4/a?revcount=30">less</a>
  <a href="/log/4/a?revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> 
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  

first deleted - one revision

  $ (get-with-headers.py localhost:$HGPORT 'log/3/a')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: a history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/a" title="Atom feed for test:a" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/a" title="RSS feed for test:a" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/3">log</a></li>
  <li><a href="/graph/3">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/3">changeset</a></li>
  <li><a href="/file/3">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/3/a">file</a></li>
  <li><a href="/diff/3/a">diff</a></li>
  <li><a href="/comparison/3/a">comparison</a></li>
  <li><a href="/annotate/3/a">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/3/a">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/a" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log a @ 1:<a href="/rev/5ed941583260">5ed941583260</a>
   <span class="phase">draft</span> <span class="tag">a-tag</span> <span class="tag">a-bookmark</span> 
   
  </h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/3/a?revcount=30">less</a>
  <a href="/log/3/a?revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/5ed941583260">first a</a>
     <span class="phase">draft</span> <span class="tag">a-tag</span> <span class="tag">a-bookmark</span> 
    </td>
   </tr>
   
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/3/a?revcount=30">less</a>
  <a href="/log/3/a?revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> 
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  

first version - one revision

  $ (get-with-headers.py localhost:$HGPORT 'log/1/a')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: a history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/a" title="Atom feed for test:a" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/a" title="RSS feed for test:a" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/1">log</a></li>
  <li><a href="/graph/1">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/1">changeset</a></li>
  <li><a href="/file/1">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/1/a">file</a></li>
  <li><a href="/diff/1/a">diff</a></li>
  <li><a href="/comparison/1/a">comparison</a></li>
  <li><a href="/annotate/1/a">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/1/a">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/a" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log a @ 1:<a href="/rev/5ed941583260">5ed941583260</a>
   <span class="phase">draft</span> <span class="tag">a-tag</span> <span class="tag">a-bookmark</span> 
   
  </h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/1/a?revcount=30">less</a>
  <a href="/log/1/a?revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/5ed941583260">first a</a>
     <span class="phase">draft</span> <span class="tag">a-tag</span> <span class="tag">a-bookmark</span> 
    </td>
   </tr>
   
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/1/a?revcount=30">less</a>
  <a href="/log/1/a?revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> 
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  

before addition - error

  $ (get-with-headers.py localhost:$HGPORT 'log/0/a')
  404 Not Found
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: error</title>
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" width=75 height=90 border=0 alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog">log</a></li>
  <li><a href="/graph">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  </div>
  
  <div class="main">
  
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>error</h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="description">
  <p>
  An error occurred while processing your request:
  </p>
  <p>
  a@6563da9dcf87: not found in manifest
  </p>
  </div>
  </div>
  </div>
  
  
  
  </body>
  </html>
  
  [1]

  $ hg log -r 'followlines(c, 1:2, startrev=tip) and follow(c)'
  changeset:   0:6563da9dcf87
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     b
  
  changeset:   7:46c1a66bd8fc
  branch:      a-branch
  tag:         tip
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     change c
  
  $ (get-with-headers.py localhost:$HGPORT 'log/tip/c?linerange=1:2')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: c history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/c" title="Atom feed for test:c" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/c" title="RSS feed for test:c" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/tip">log</a></li>
  <li><a href="/graph/tip">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/tip">changeset</a></li>
  <li><a href="/file/tip">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/tip/c">file</a></li>
  <li><a href="/diff/tip/c">diff</a></li>
  <li><a href="/comparison/tip/c">comparison</a></li>
  <li><a href="/annotate/tip/c">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/tip/c">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/c" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log c @ 7:<a href="/rev/46c1a66bd8fc">46c1a66bd8fc</a>
   <span class="phase">draft</span> <span class="branchhead">a-branch</span> <span class="tag">tip</span> 
    (following lines 1:2 <a href="/log/tip/c">all revisions for this file</a>)
  </h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/tip/c?linerange=1%3A2&revcount=30">less</a>
  <a href="/log/tip/c?linerange=1%3A2&revcount=120">more</a>
  |  </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/46c1a66bd8fc">change c</a>
     <span class="phase">draft</span> <span class="branchhead">a-branch</span> <span class="tag">tip</span> 
    </td>
   </tr>
   
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/6563da9dcf87">b</a>
     <span class="phase">draft</span> 
    </td>
   </tr>
   
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/tip/c?linerange=1%3A2&revcount=30">less</a>
  <a href="/log/tip/c?linerange=1%3A2&revcount=120">more</a>
  |  
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  
  $ (get-with-headers.py localhost:$HGPORT 'log/tip/c?linerange=1%3A2&revcount=1')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: c history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/c" title="Atom feed for test:c" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/c" title="RSS feed for test:c" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/tip?revcount=1">log</a></li>
  <li><a href="/graph/tip?revcount=1">graph</a></li>
  <li><a href="/tags?revcount=1">tags</a></li>
  <li><a href="/bookmarks?revcount=1">bookmarks</a></li>
  <li><a href="/branches?revcount=1">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/tip?revcount=1">changeset</a></li>
  <li><a href="/file/tip?revcount=1">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/tip/c?revcount=1">file</a></li>
  <li><a href="/diff/tip/c?revcount=1">diff</a></li>
  <li><a href="/comparison/tip/c?revcount=1">comparison</a></li>
  <li><a href="/annotate/tip/c?revcount=1">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/tip/c">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help?revcount=1">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/c" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log c @ 7:<a href="/rev/46c1a66bd8fc?revcount=1">46c1a66bd8fc</a>
   <span class="phase">draft</span> <span class="branchhead">a-branch</span> <span class="tag">tip</span> 
    (following lines 1:2 <a href="/log/tip/c?revcount=1">all revisions for this file</a>)
  </h3>
  
  
  <form class="search" action="/log">
  <input type="hidden" name="revcount" value="1" />
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/tip/c?linerange=1%3A2&revcount=1">less</a>
  <a href="/log/tip/c?linerange=1%3A2&revcount=2">more</a>
  |  </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/46c1a66bd8fc?revcount=1">change c</a>
     <span class="phase">draft</span> <span class="branchhead">a-branch</span> <span class="tag">tip</span> 
    </td>
   </tr>
   
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/tip/c?linerange=1%3A2&revcount=1">less</a>
  <a href="/log/tip/c?linerange=1%3A2&revcount=2">more</a>
  |  
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  
  $ (get-with-headers.py localhost:$HGPORT 'log/3/a?linerange=1' --headeronly)
  400 invalid linerange parameter
  [1]
  $ (get-with-headers.py localhost:$HGPORT 'log/3/a?linerange=1:a' --headeronly)
  400 invalid linerange parameter
  [1]
  $ (get-with-headers.py localhost:$HGPORT 'log/3/a?linerange=1:2&linerange=3:4' --headeronly)
  400 redundant linerange parameter
  [1]
  $ (get-with-headers.py localhost:$HGPORT 'log/3/a?linerange=3:2' --headeronly)
  400 line range must be positive
  [1]
  $ (get-with-headers.py localhost:$HGPORT 'log/3/a?linerange=0:1' --headeronly)
  400 fromline must be strictly positive
  [1]

should show base link, use spartan because it shows it

  $ (get-with-headers.py localhost:$HGPORT 'log/tip/c?style=spartan')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
  <html>
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png">
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: c history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/c" title="Atom feed for test:c">
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/c" title="RSS feed for test:c">
  </head>
  <body>
  
  <div class="buttons">
  <a href="/log?style=spartan">changelog</a>
  <a href="/shortlog?style=spartan">shortlog</a>
  <a href="/graph?style=spartan">graph</a>
  <a href="/tags?style=spartan">tags</a>
  <a href="/branches?style=spartan">branches</a>
  <a href="/file/tip/c?style=spartan">file</a>
  <a href="/annotate/tip/c?style=spartan">annotate</a>
  <a href="/help?style=spartan">help</a>
  <a type="application/rss+xml" href="/rss-log/tip/c">rss</a>
  <a type="application/atom+xml" href="/atom-log/tip/c" title="Atom feed for test:c">atom</a>
  </div>
  
  <h2><a href="/">Mercurial</a>  / c revision history</h2>
  
  <p>navigate: <small class="navigate"><a href="/log/c9637d3cc8ef/c?style=spartan">(0)</a> <a href="/log/tip/c?style=spartan">tip</a> </small></p>
  
  <table class="logEntry parity0">
   <tr>
    <th class="label"><span class="age">Thu, 01 Jan 1970 00:00:00 +0000</span>:</th>
    <th class="firstline"><a href="/rev/46c1a66bd8fc?style=spartan">change c</a></th>
   </tr>
   <tr>
    <th class="revision">revision 1:</th>
    <td class="node">
     <a href="/file/46c1a66bd8fc/c?style=spartan">46c1a66bd8fc</a>
     <a href="/diff/46c1a66bd8fc/c?style=spartan">(diff)</a>
     <a href="/annotate/46c1a66bd8fc/c?style=spartan">(annotate)</a>
    </td>
   </tr>
   
   <tr>
    <th class="author">author:</th>
    <td class="author">&#116;&#101;&#115;&#116;</td>
   </tr>
   <tr>
    <th class="date">date:</th>
    <td class="date">Thu, 01 Jan 1970 00:00:00 +0000</td>
   </tr>
  </table>
  
  
  <table class="logEntry parity1">
   <tr>
    <th class="label"><span class="age">Thu, 01 Jan 1970 00:00:00 +0000</span>:</th>
    <th class="firstline"><a href="/rev/c9637d3cc8ef?style=spartan">mv b</a></th>
   </tr>
   <tr>
    <th class="revision">revision 0:</th>
    <td class="node">
     <a href="/file/c9637d3cc8ef/c?style=spartan">c9637d3cc8ef</a>
     <a href="/diff/c9637d3cc8ef/c?style=spartan">(diff)</a>
     <a href="/annotate/c9637d3cc8ef/c?style=spartan">(annotate)</a>
    </td>
   </tr>
   
  <tr>
  <th>base:</th>
  <td>
  <a href="/file/1e88685f5dde/b?style=spartan">
  b@1e88685f5dde
  </a>
  </td>
  </tr>
   <tr>
    <th class="author">author:</th>
    <td class="author">&#116;&#101;&#115;&#116;</td>
   </tr>
   <tr>
    <th class="date">date:</th>
    <td class="date">Thu, 01 Jan 1970 00:00:00 +0000</td>
   </tr>
  </table>
  
  
  
  
  
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" width=75 height=90 border=0 alt="mercurial"></a>
  </div>
  
  </body>
  </html>
  

filelog with patch

  $ (get-with-headers.py localhost:$HGPORT 'log/4/a?patch=1')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: a history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/a" title="Atom feed for test:a" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/a" title="RSS feed for test:a" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/4">log</a></li>
  <li><a href="/graph/4">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/4">changeset</a></li>
  <li><a href="/file/4">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/4/a">file</a></li>
  <li><a href="/diff/4/a">diff</a></li>
  <li><a href="/comparison/4/a">comparison</a></li>
  <li><a href="/annotate/4/a">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/4/a">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/a" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log a @ 4:<a href="/rev/3f41bc784e7e">3f41bc784e7e</a>
   <span class="phase">draft</span> <span class="branchname">a-branch</span> 
   
  </h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/4/a?patch=1&revcount=30">less</a>
  <a href="/log/4/a?patch=1&revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/3f41bc784e7e">second a</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   <tr><td colspan="3"><div class="bottomline inc-lineno"><pre class="sourcelines wrap">
  <span id="3f41bc784e7e-l1.1" class="minusline">--- /dev/null	Thu Jan 01 00:00:00 1970 +0000</span><a href="#3f41bc784e7e-l1.1"></a>
  <span id="3f41bc784e7e-l1.2" class="plusline">+++ b/a	Thu Jan 01 00:00:00 1970 +0000</span><a href="#3f41bc784e7e-l1.2"></a>
  <span id="3f41bc784e7e-l1.3" class="atline">@@ -0,0 +1,1 @@</span><a href="#3f41bc784e7e-l1.3"></a>
  <span id="3f41bc784e7e-l1.4" class="plusline">+b</span><a href="#3f41bc784e7e-l1.4"></a></pre></div></td></tr>
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/5ed941583260">first a</a>
     <span class="phase">draft</span> <span class="tag">a-tag</span> <span class="tag">a-bookmark</span> 
    </td>
   </tr>
   <tr><td colspan="3"><div class="bottomline inc-lineno"><pre class="sourcelines wrap">
  <span id="5ed941583260-l1.1" class="minusline">--- /dev/null	Thu Jan 01 00:00:00 1970 +0000</span><a href="#5ed941583260-l1.1"></a>
  <span id="5ed941583260-l1.2" class="plusline">+++ b/a	Thu Jan 01 00:00:00 1970 +0000</span><a href="#5ed941583260-l1.2"></a>
  <span id="5ed941583260-l1.3" class="atline">@@ -0,0 +1,1 @@</span><a href="#5ed941583260-l1.3"></a>
  <span id="5ed941583260-l1.4" class="plusline">+a</span><a href="#5ed941583260-l1.4"></a></pre></div></td></tr>
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/4/a?patch=1&revcount=30">less</a>
  <a href="/log/4/a?patch=1&revcount=120">more</a>
  | <a href="/log/5ed941583260/a">(0)</a> <a href="/log/tip/a">tip</a> 
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  
filelog with 'linerange' and 'patch'

  $ cat c
  b
  c
  $ cat <<EOF > c
  > 0
  > 0
  > b
  > c+
  > 
  > a
  > a
  > 
  > d
  > e
  > f
  > EOF
  $ hg ci -m 'make c bigger and touch its beginning' c
  $ cat <<EOF > c
  > 0
  > 0
  > b
  > c+
  > 
  > a
  > a
  > 
  > d
  > e+
  > f
  > EOF
  $ hg ci -m 'just touch end of c' c
  $ cat <<EOF > c
  > 0
  > 0
  > b
  > c++
  > 
  > a
  > a
  > 
  > d
  > e+
  > f
  > EOF
  $ hg ci -m 'touch beginning of c' c
  $ cat <<EOF > c
  > 0
  > 0
  > b-
  > c++
  > 
  > a
  > a
  > 
  > d
  > e+
  > f+
  > EOF
  $ hg ci -m 'touching beginning and end of c' c
  $ echo c > cc
  $ hg ci -Am 'tip does not touch c' cc
  $ hg log -r 'followlines(c, 3:4, startrev=tip) and follow(c)' -p
  changeset:   0:6563da9dcf87
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     b
  
  diff -r 000000000000 -r 6563da9dcf87 b
  --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
  +++ b/b	Thu Jan 01 00:00:00 1970 +0000
  @@ -0,0 +1,1 @@
  +b
  
  changeset:   7:46c1a66bd8fc
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     change c
  
  diff -r c9637d3cc8ef -r 46c1a66bd8fc c
  --- a/c	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,1 +1,2 @@
   b
  +c
  
  changeset:   8:5c6574614c37
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     make c bigger and touch its beginning
  
  diff -r 46c1a66bd8fc -r 5c6574614c37 c
  --- a/c	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,2 +1,11 @@
  +0
  +0
   b
  -c
  +c+
  +
  +a
  +a
  +
  +d
  +e
  +f
  
  changeset:   10:e95928d60479
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     touch beginning of c
  
  diff -r e1d3e9c5a23f -r e95928d60479 c
  --- a/c	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,7 +1,7 @@
   0
   0
   b
  -c+
  +c++
   
   a
   a
  
  changeset:   11:fb9bc322513a
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     touching beginning and end of c
  
  diff -r e95928d60479 -r fb9bc322513a c
  --- a/c	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,6 +1,6 @@
   0
   0
  -b
  +b-
   c++
   
   a
  @@ -8,4 +8,4 @@
   
   d
   e+
  -f
  +f+
  
  $ (get-with-headers.py localhost:$HGPORT 'log/tip/c?linerange=3:4&patch=')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: c history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/c" title="Atom feed for test:c" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/c" title="RSS feed for test:c" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/tip">log</a></li>
  <li><a href="/graph/tip">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/tip">changeset</a></li>
  <li><a href="/file/tip">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/tip/c">file</a></li>
  <li><a href="/diff/tip/c">diff</a></li>
  <li><a href="/comparison/tip/c">comparison</a></li>
  <li><a href="/annotate/tip/c">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/tip/c">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/c" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log c @ 12:<a href="/rev/6e4182052f7b">6e4182052f7b</a>
   <span class="phase">draft</span> <span class="branchhead">a-branch</span> <span class="tag">tip</span> 
    (following lines 3:4 <a href="/log/tip/c">all revisions for this file</a>)
  </h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/tip/c?linerange=3%3A4&patch=&revcount=30">less</a>
  <a href="/log/tip/c?linerange=3%3A4&patch=&revcount=120">more</a>
  |  </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/fb9bc322513a">touching beginning and end of c</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   <tr><td colspan="3"><div class="bottomline inc-lineno"><pre class="sourcelines wrap">
  <span id="fb9bc322513a-l1.1" class="minusline">--- a/c	Thu Jan 01 00:00:00 1970 +0000</span><a href="#fb9bc322513a-l1.1"></a>
  <span id="fb9bc322513a-l1.2" class="plusline">+++ b/c	Thu Jan 01 00:00:00 1970 +0000</span><a href="#fb9bc322513a-l1.2"></a>
  <span id="fb9bc322513a-l1.3" class="atline">@@ -1,6 +1,6 @@</span><a href="#fb9bc322513a-l1.3"></a>
  <span id="fb9bc322513a-l1.4"> 0</span><a href="#fb9bc322513a-l1.4"></a>
  <span id="fb9bc322513a-l1.5"> 0</span><a href="#fb9bc322513a-l1.5"></a>
  <span id="fb9bc322513a-l1.6" class="minusline">-b</span><a href="#fb9bc322513a-l1.6"></a>
  <span id="fb9bc322513a-l1.7" class="plusline">+b-</span><a href="#fb9bc322513a-l1.7"></a>
  <span id="fb9bc322513a-l1.8"> c++</span><a href="#fb9bc322513a-l1.8"></a>
  <span id="fb9bc322513a-l1.9"> </span><a href="#fb9bc322513a-l1.9"></a>
  <span id="fb9bc322513a-l1.10"> a</span><a href="#fb9bc322513a-l1.10"></a></pre></div></td></tr>
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/e95928d60479">touch beginning of c</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   <tr><td colspan="3"><div class="bottomline inc-lineno"><pre class="sourcelines wrap">
  <span id="e95928d60479-l1.1" class="minusline">--- a/c	Thu Jan 01 00:00:00 1970 +0000</span><a href="#e95928d60479-l1.1"></a>
  <span id="e95928d60479-l1.2" class="plusline">+++ b/c	Thu Jan 01 00:00:00 1970 +0000</span><a href="#e95928d60479-l1.2"></a>
  <span id="e95928d60479-l1.3" class="atline">@@ -1,7 +1,7 @@</span><a href="#e95928d60479-l1.3"></a>
  <span id="e95928d60479-l1.4"> 0</span><a href="#e95928d60479-l1.4"></a>
  <span id="e95928d60479-l1.5"> 0</span><a href="#e95928d60479-l1.5"></a>
  <span id="e95928d60479-l1.6"> b</span><a href="#e95928d60479-l1.6"></a>
  <span id="e95928d60479-l1.7" class="minusline">-c+</span><a href="#e95928d60479-l1.7"></a>
  <span id="e95928d60479-l1.8" class="plusline">+c++</span><a href="#e95928d60479-l1.8"></a>
  <span id="e95928d60479-l1.9"> </span><a href="#e95928d60479-l1.9"></a>
  <span id="e95928d60479-l1.10"> a</span><a href="#e95928d60479-l1.10"></a>
  <span id="e95928d60479-l1.11"> a</span><a href="#e95928d60479-l1.11"></a></pre></div></td></tr>
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/5c6574614c37">make c bigger and touch its beginning</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   <tr><td colspan="3"><div class="bottomline inc-lineno"><pre class="sourcelines wrap">
  <span id="5c6574614c37-l1.1" class="minusline">--- a/c	Thu Jan 01 00:00:00 1970 +0000</span><a href="#5c6574614c37-l1.1"></a>
  <span id="5c6574614c37-l1.2" class="plusline">+++ b/c	Thu Jan 01 00:00:00 1970 +0000</span><a href="#5c6574614c37-l1.2"></a>
  <span id="5c6574614c37-l1.3" class="atline">@@ -1,2 +1,11 @@</span><a href="#5c6574614c37-l1.3"></a>
  <span id="5c6574614c37-l1.4" class="plusline">+0</span><a href="#5c6574614c37-l1.4"></a>
  <span id="5c6574614c37-l1.5" class="plusline">+0</span><a href="#5c6574614c37-l1.5"></a>
  <span id="5c6574614c37-l1.6"> b</span><a href="#5c6574614c37-l1.6"></a>
  <span id="5c6574614c37-l1.7" class="minusline">-c</span><a href="#5c6574614c37-l1.7"></a>
  <span id="5c6574614c37-l1.8" class="plusline">+c+</span><a href="#5c6574614c37-l1.8"></a>
  <span id="5c6574614c37-l1.9" class="plusline">+</span><a href="#5c6574614c37-l1.9"></a>
  <span id="5c6574614c37-l1.10" class="plusline">+a</span><a href="#5c6574614c37-l1.10"></a>
  <span id="5c6574614c37-l1.11" class="plusline">+a</span><a href="#5c6574614c37-l1.11"></a>
  <span id="5c6574614c37-l1.12" class="plusline">+</span><a href="#5c6574614c37-l1.12"></a>
  <span id="5c6574614c37-l1.13" class="plusline">+d</span><a href="#5c6574614c37-l1.13"></a>
  <span id="5c6574614c37-l1.14" class="plusline">+e</span><a href="#5c6574614c37-l1.14"></a>
  <span id="5c6574614c37-l1.15" class="plusline">+f</span><a href="#5c6574614c37-l1.15"></a></pre></div></td></tr>
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/46c1a66bd8fc">change c</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   <tr><td colspan="3"><div class="bottomline inc-lineno"><pre class="sourcelines wrap">
  <span id="46c1a66bd8fc-l1.1" class="minusline">--- a/c	Thu Jan 01 00:00:00 1970 +0000</span><a href="#46c1a66bd8fc-l1.1"></a>
  <span id="46c1a66bd8fc-l1.2" class="plusline">+++ b/c	Thu Jan 01 00:00:00 1970 +0000</span><a href="#46c1a66bd8fc-l1.2"></a>
  <span id="46c1a66bd8fc-l1.3" class="atline">@@ -1,1 +1,2 @@</span><a href="#46c1a66bd8fc-l1.3"></a>
  <span id="46c1a66bd8fc-l1.4"> b</span><a href="#46c1a66bd8fc-l1.4"></a>
  <span id="46c1a66bd8fc-l1.5" class="plusline">+c</span><a href="#46c1a66bd8fc-l1.5"></a></pre></div></td></tr>
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/6563da9dcf87">b</a>
     <span class="phase">draft</span> 
    </td>
   </tr>
   <tr><td colspan="3"><div class="bottomline inc-lineno"><pre class="sourcelines wrap">
  <span id="6563da9dcf87-l1.1" class="minusline">--- /dev/null	Thu Jan 01 00:00:00 1970 +0000</span><a href="#6563da9dcf87-l1.1"></a>
  <span id="6563da9dcf87-l1.2" class="plusline">+++ b/b	Thu Jan 01 00:00:00 1970 +0000</span><a href="#6563da9dcf87-l1.2"></a></pre></div></td></tr>
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/tip/c?linerange=3%3A4&patch=&revcount=30">less</a>
  <a href="/log/tip/c?linerange=3%3A4&patch=&revcount=120">more</a>
  |  
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  
  $ hg log -r 'followlines(c, 3:4, startrev=8, descend=True) and follow(c)' -p
  changeset:   8:5c6574614c37
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     make c bigger and touch its beginning
  
  diff -r 46c1a66bd8fc -r 5c6574614c37 c
  --- a/c	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,2 +1,11 @@
  +0
  +0
   b
  -c
  +c+
  +
  +a
  +a
  +
  +d
  +e
  +f
  
  changeset:   10:e95928d60479
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     touch beginning of c
  
  diff -r e1d3e9c5a23f -r e95928d60479 c
  --- a/c	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,7 +1,7 @@
   0
   0
   b
  -c+
  +c++
   
   a
   a
  
  changeset:   11:fb9bc322513a
  branch:      a-branch
  user:        test
  date:        Thu Jan 01 00:00:00 1970 +0000
  summary:     touching beginning and end of c
  
  diff -r e95928d60479 -r fb9bc322513a c
  --- a/c	Thu Jan 01 00:00:00 1970 +0000
  +++ b/c	Thu Jan 01 00:00:00 1970 +0000
  @@ -1,6 +1,6 @@
   0
   0
  -b
  +b-
   c++
   
   a
  @@ -8,4 +8,4 @@
   
   d
   e+
  -f
  +f+
  
  $ (get-with-headers.py localhost:$HGPORT 'log/8/c?linerange=3:4&descend=')
  200 Script output follows
  
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
  <head>
  <link rel="icon" href="/static/hgicon.png" type="image/png" />
  <meta name="robots" content="index, nofollow" />
  <link rel="stylesheet" href="/static/style-paper.css" type="text/css" />
  <script type="text/javascript" src="/static/mercurial.js"></script>
  
  <title>test: c history</title>
  <link rel="alternate" type="application/atom+xml"
     href="/atom-log/tip/c" title="Atom feed for test:c" />
  <link rel="alternate" type="application/rss+xml"
     href="/rss-log/tip/c" title="RSS feed for test:c" />
  </head>
  <body>
  
  <div class="container">
  <div class="menu">
  <div class="logo">
  <a href="https://mercurial-scm.org/">
  <img src="/static/hglogo.png" alt="mercurial" /></a>
  </div>
  <ul>
  <li><a href="/shortlog/8">log</a></li>
  <li><a href="/graph/8">graph</a></li>
  <li><a href="/tags">tags</a></li>
  <li><a href="/bookmarks">bookmarks</a></li>
  <li><a href="/branches">branches</a></li>
  </ul>
  <ul>
  <li><a href="/rev/8">changeset</a></li>
  <li><a href="/file/8">browse</a></li>
  </ul>
  <ul>
  <li><a href="/file/8/c">file</a></li>
  <li><a href="/diff/8/c">diff</a></li>
  <li><a href="/comparison/8/c">comparison</a></li>
  <li><a href="/annotate/8/c">annotate</a></li>
  <li class="active">file log</li>
  <li><a href="/raw-file/8/c">raw</a></li>
  </ul>
  <ul>
  <li><a href="/help">help</a></li>
  </ul>
  <div class="atom-logo">
  <a href="/atom-log/tip/c" title="subscribe to atom feed">
  <img class="atom-logo" src="/static/feed-icon-14x14.png" alt="atom feed" />
  </a>
  </div>
  </div>
  
  <div class="main">
  <h2 class="breadcrumb"><a href="/">Mercurial</a> </h2>
  <h3>
   log c @ 8:<a href="/rev/5c6574614c37">5c6574614c37</a>
   <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    (following lines 3:4, descending <a href="/log/8/c">all revisions for this file</a>)
  </h3>
  
  
  <form class="search" action="/log">
  
  <p><input name="rev" id="search1" type="text" size="30" value="" /></p>
  <div id="hint">Find changesets by keywords (author, files, the commit message), revision
  number or hash, or <a href="/help/revsets">revset expression</a>.</div>
  </form>
  
  <div class="navigate">
  <a href="/log/8/c?descend=&linerange=3%3A4&revcount=30">less</a>
  <a href="/log/8/c?descend=&linerange=3%3A4&revcount=120">more</a>
  |  </div>
  
  <table class="bigtable">
  <thead>
   <tr>
    <th class="age">age</th>
    <th class="author">author</th>
    <th class="description">description</th>
   </tr>
  </thead>
  <tbody class="stripes2">
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/5c6574614c37">make c bigger and touch its beginning</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/e95928d60479">touch beginning of c</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   
   <tr>
    <td class="age">Thu, 01 Jan 1970 00:00:00 +0000</td>
    <td class="author">test</td>
    <td class="description">
     <a href="/rev/fb9bc322513a">touching beginning and end of c</a>
     <span class="phase">draft</span> <span class="branchname">a-branch</span> 
    </td>
   </tr>
   
  
  </tbody>
  </table>
  
  <div class="navigate">
  <a href="/log/8/c?descend=&linerange=3%3A4&revcount=30">less</a>
  <a href="/log/8/c?descend=&linerange=3%3A4&revcount=120">more</a>
  |  
  </div>
  
  </div>
  </div>
  
  
  
  </body>
  </html>
  

rss log

  $ (get-with-headers.py localhost:$HGPORT 'rss-log/tip/a')
  200 Script output follows
  
  <?xml version="1.0" encoding="ascii"?>
  <rss version="2.0">
    <channel>
      <link>http://*:$HGPORT/</link> (glob)
      <language>en-us</language>
  
      <title>test: a history</title>
      <description>a revision history</description>
      <item>
      <title>second a</title>
      <link>http://*:$HGPORT/log/3f41bc784e7e/a</link> (glob)
      <description><![CDATA[second a]]></description>
      <author>&#116;&#101;&#115;&#116;</author>
      <pubDate>Thu, 01 Jan 1970 00:00:00 +0000</pubDate>
  </item>
  <item>
      <title>first a</title>
      <link>http://*:$HGPORT/log/5ed941583260/a</link> (glob)
      <description><![CDATA[first a]]></description>
      <author>&#116;&#101;&#115;&#116;</author>
      <pubDate>Thu, 01 Jan 1970 00:00:00 +0000</pubDate>
  </item>
  
    </channel>
  </rss>

atom log

  $ (get-with-headers.py localhost:$HGPORT 'atom-log/tip/a')
  200 Script output follows
  
  <?xml version="1.0" encoding="ascii"?>
  <feed xmlns="http://www.w3.org/2005/Atom">
   <id>http://*:$HGPORT/atom-log/tip/a</id> (glob)
   <link rel="self" href="http://*:$HGPORT/atom-log/tip/a"/> (glob)
   <title>test: a history</title>
   <updated>1970-01-01T00:00:00+00:00</updated>
  
   <entry>
    <title>[a-branch] second a</title>
    <id>http://*:$HGPORT/#changeset-3f41bc784e7e73035c6d47112c6cc7efb673adf8</id> (glob)
    <link href="http://*:$HGPORT/rev/3f41bc784e7e"/> (glob)
    <author>
     <name>test</name>
     <email>&#116;&#101;&#115;&#116;</email>
    </author>
    <updated>1970-01-01T00:00:00+00:00</updated>
    <published>1970-01-01T00:00:00+00:00</published>
    <content type="xhtml">
     <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
       <th style="text-align:left;">changeset</th>
       <td>3f41bc784e7e</td>
      </tr>
      <tr>
       <th style="text-align:left;">branch</th>
       <td>a-branch</td>
      </tr>
      <tr>
       <th style="text-align:left;">bookmark</th>
       <td></td>
      </tr>
      <tr>
       <th style="text-align:left;">tag</th>
       <td></td>
      </tr>
      <tr>
       <th style="text-align:left;">user</th>
       <td>&#116;&#101;&#115;&#116;</td>
      </tr>
      <tr>
       <th style="text-align:left;vertical-align:top;">description</th>
       <td>second a</td>
      </tr>
      <tr>
       <th style="text-align:left;vertical-align:top;">files</th>
       <td></td>
      </tr>
     </table>
    </content>
   </entry>
   <entry>
    <title>first a</title>
    <id>http://*:$HGPORT/#changeset-5ed941583260248620985524192fdc382ef57c36</id> (glob)
    <link href="http://*:$HGPORT/rev/5ed941583260"/> (glob)
    <author>
     <name>test</name>
     <email>&#116;&#101;&#115;&#116;</email>
    </author>
    <updated>1970-01-01T00:00:00+00:00</updated>
    <published>1970-01-01T00:00:00+00:00</published>
    <content type="xhtml">
     <table xmlns="http://www.w3.org/1999/xhtml">
      <tr>
       <th style="text-align:left;">changeset</th>
       <td>5ed941583260</td>
      </tr>
      <tr>
       <th style="text-align:left;">branch</th>
       <td></td>
      </tr>
      <tr>
       <th style="text-align:left;">bookmark</th>
       <td>a-bookmark</td>
      </tr>
      <tr>
       <th style="text-align:left;">tag</th>
       <td>a-tag</td>
      </tr>
      <tr>
       <th style="text-align:left;">user</th>
       <td>&#116;&#101;&#115;&#116;</td>
      </tr>
      <tr>
       <th style="text-align:left;vertical-align:top;">description</th>
       <td>first a</td>
      </tr>
      <tr>
       <th style="text-align:left;vertical-align:top;">files</th>
       <td></td>
      </tr>
     </table>
    </content>
   </entry>
  
  </feed>

errors

  $ cat errors.log

  $ cd ..
