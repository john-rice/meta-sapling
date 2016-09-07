// treemanifest.h - c++ declarations of a tree manifest
//
// Copyright 2016 Facebook, Inc.
//
// This software may be used and distributed according to the terms of the
// GNU General Public License version 2 or any later version.
//
// no-check-code

#ifndef REMOTEFILELOG_TREEMANIFEST_H
#define REMOTEFILELOG_TREEMANIFEST_H

#include "pythonutil.h"

#include <string>
#include <vector>

#include "manifest_fetcher.h"

enum FindResult {
  FIND_PATH_OK,
  FIND_PATH_NOT_FOUND,
  FIND_PATH_CONFLICT,
  FIND_PATH_WTF,
};

enum FindMode {
  // walks the tree and searches for a leaf node.  if the path cannot be found,
  // exit with `FIND_PATH_NOT_FOUND`.
      BASIC_WALK,

  // walks the tree.  if the intermediate paths cannot be found, create them.
  // if a leaf node exists where an intermediate path node needs to be
  // created, then return `FIND_PATH_CONFLICT`.
      CREATE_IF_MISSING,

  // walks the tree.  if the path cannot be found, exit with
  // `FIND_PATH_NOT_FOUND`.  if the operation is successful, then check
  // intermediate nodes to ensure that they still have children.  any nodes
  // that do not should be removed.
      REMOVE_EMPTY_IMPLICIT_NODES,
};

struct FindContext {
  bool invalidate_checksums;
  int32_t num_leaf_node_changes;
  FindMode mode;

  // reuse this space when fetching manifests.
  std::string nodebuffer;

  // any extra data the callback needs to complete the operation.
  void *extras;
};

class PathIterator {
  private:
    std::string path;
    size_t position;
  public:
    PathIterator(std::string path) {
      this->path = path;
      this->position = 0;
    }

    bool next(char const ** word, size_t *wordlen) {
      if (this->isfinished()) {
        return false;
      }

      *word = this->path.c_str() + this->position;
      size_t slashoffset = this->path.find('/', this->position);
      if (slashoffset == std::string::npos) {
        *wordlen = this->path.length() - this->position;
      } else {
        *wordlen = slashoffset - this->position;
      }

      this->position += *wordlen + 1;

      return true;
    }

    bool isfinished() {
      return this->position >= this->path.length();
    }

    void getPathToPosition(const char **word, size_t *wordlen) {
      *word = path.c_str();
      *wordlen = this->position;
    }
};

/**
 * A single instance of a treemanifest.
 */
struct treemanifest {
    // Fetcher for the manifests.
    ManifestFetcher fetcher;

    // The 20-byte root node of this manifest
    std::string rootNode;

    treemanifest(PythonObj store, std::string rootNode) :
        fetcher(store),
        rootNode(rootNode),
        rootManifest_DO_NOT_ACCESS_DIRECTLY(NULL) {
    }

    treemanifest(PythonObj store) :
        fetcher(store),
        rootManifest_DO_NOT_ACCESS_DIRECTLY(new Manifest()) {
    }

    ~treemanifest();

    void get(
        const std::string &filename,
        std::string *resultnode, char *resultflag);

    Manifest *getRootManifest() {
      if (this->rootManifest_DO_NOT_ACCESS_DIRECTLY == NULL) {
        this->rootManifest_DO_NOT_ACCESS_DIRECTLY =
            fetcher.get(NULL, 0, this->rootNode);
      }

      return this->rootManifest_DO_NOT_ACCESS_DIRECTLY;
    }

  private:
    // The resolved Manifest node, if the root has already been resolved.
    // Avoid accessing this directly as it may not be set.  Instead, use
    // getRootManifest() to retrieve the root manifest.
    Manifest *rootManifest_DO_NOT_ACCESS_DIRECTLY;

    /**
     * Basic mechanism to traverse a tree.  Once the deepest directory in the
     * path has been located, the supplied callback is executed.  That callback
     * is called with the manifest of the deepest directory and the leaf node's
     * filename.
     *
     * For instance, if treemanifest_find is called on /abc/def/ghi, then the
     * callback is executed with the manifest of /abc/def, and the filename
     * passed in will be "ghi".
     */
    FindResult find(
        Manifest *manifest,
        PathIterator &path,
        FindMode findMode,
        FindContext *findContext,
        FindResult (*callback)(
            Manifest *manifest,
            const char *filename, size_t filenamelen,
            FindContext *findContext));
};

/**
 * Represents a single stack frame in an iteration of the contents of the tree.
 */
struct stackframe {
  Manifest *manifest;
  ManifestIterator iterator;

  stackframe(Manifest *manifest) :
      manifest(manifest),
      iterator(manifest->getIterator()) {
  }
};

/**
 * A helper struct representing the state of an iterator recursing over a tree.
 */
struct fileiter {
  ManifestFetcher fetcher;      // Instance to fetch tree content
  std::vector<stackframe> frames;
  std::string path;             // The fullpath for the top entry in the stack.

  // If provided, the given matcher filters the results by path
  PythonObj matcher;

  fileiter(treemanifest &tm) :
      fetcher(tm.fetcher) {
    this->frames.push_back(stackframe(tm.getRootManifest()));
    this->path.reserve(1024);
  }

  fileiter(const fileiter &old) :
      fetcher(old.fetcher),
      frames(old.frames),
      path(old.path) {
  }

  fileiter& operator=(const fileiter &other) {
    this->fetcher = other.fetcher;
    this->frames = other.frames;
    this->path = other.path;

    return *this;
  }
};

extern void treemanifest_diffrecurse(
    Manifest *selfmf,
    Manifest *othermf,
    std::string &path,
    const PythonObj &diff,
    const ManifestFetcher &fetcher);

#endif //REMOTEFILELOG_TREEMANIFEST_H
