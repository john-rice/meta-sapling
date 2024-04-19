#require git no-windows no-eden

Test path_copies() configs

  $ hg init --git repo2
  $ cd repo2
  $ setupconfig
  $ drawdag <<'EOS'
  > D   # D/z = 1\n (renamed from y)
  > |   # D/D = (removed)
  > C   # C/y = 1\n (renamed from x)
  > |   # C/C = (removed)
  > | B # B/x = 1\n2\n
  > |/
  > A   # A/x = 1\n
  > EOS

  $ hg st -C --change $D
  A z
    y
  R y
  $ hg diff -r $A -r $D
  diff --git a/x b/z
  rename from x
  rename to z
  $ hg diff -r $A -r $D --config copytrace.pathcopiescommitlimit=0
  diff --git a/x b/x
  deleted file mode 100644
  --- a/x
  +++ /dev/null
  @@ -1,1 +0,0 @@
  -1
  diff --git a/z b/z
  new file mode 100644
  --- /dev/null
  +++ b/z
  @@ -0,0 +1,1 @@
  +1
  $ hg diff -r $A -r $D --config copytrace.maxmissingfiles=0
  diff --git a/x b/x
  deleted file mode 100644
  --- a/x
  +++ /dev/null
  @@ -1,1 +0,0 @@
  -1
  diff --git a/z b/z
  new file mode 100644
  --- /dev/null
  +++ b/z
  @@ -0,0 +1,1 @@
  +1