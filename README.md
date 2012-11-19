# Aliases

## URLs

### ghs:
Alias for Github clone URL (SSH protocol) :

```sh
$ git clone ghs:jubianchi/atoum # Same as git clone git@github.com:jubianchi/atoum
```

### gh:
Alias for Github clone URL (Git readonly protocol) :

```sh
$ git clone gh:jubianchi/atoum # Same as git clone git://github.com/jubianchi/atoum
```

### gists:
Alias for Gist clone URL (SSH protocol) :

```sh
$ git clone gists:a52e82e9ccc25449c325.git # Same as git clone git@gist.github.com:a52e82e9ccc25449c325.git
```

### bbs:
Alias for BitBucket clone URL (SSH protocol) :

```sh
$ git clone bbs:jubianchi/atoum # Same as git clone git@bitbucket.org:jubianchi/atoum
```

### bb:
Alias for BitBucket clone URL (HTTPS readonly protocol) :

```sh
$ git clone bb:jubianchi/atoum # Same as git clone https://bitbucket.org/jubianchi/atoum
```

## Commands

### git cleanup
Cleans up the repository by pruning origin, running GC and clearing stash

```sh
$ git cleanup [<remote>] (Default: origin)
```

### git ignore
Adds an entry to the .gitignore file

```sh
$ git ignore <entry>
```

### git make
Create a new empty repository with an empty initial commit.

```sh
$ git make [<initial-commit-message>]
```

### git aliases
Lists all available aliases

```sh
$ git aliases
```

### git addall
Adds all files that are not staged and displays a light status

```sh
$ git addall
```

### git unadd
Unstages file

```sh
$ git unadd <file>
```

### git patch
alias for ```git add --patch```

```sh
$ git patch
```

### git amend
Amends the last commits keeping its original message

```sh
$ git amend
```

### git cp
Cherry-picks a commit and edit  message

```sh
$ git cp <sha1>
```

### git undo
Resets the last commit keeping the modifications (soft reset) and displays a light status

```sh
$ git undo
```

### git br(?:|a|r|n)
Displays branch list

```sh
$ git br  # Displays local branches
$ git bra # Displays all branches (local + remote)
$ git brr # Displays remote branches
$ git brn # Displays all (local + remote) not merged branches
```

### git cb
Checkout a new branch

```sh
$ git cb <branch>
```

### git finish
Finishes the current topic branch by interactively rebasing its commits and merging it into another branch

```sh
$ git finish <branch>
```

### git (?:develop|master)
Checkout the develop or master branch

```sh
$ git master
$ git develop
```

### git pwd
Displays the name of the current branch

```sh
$ git pwd
```

### git go
Checkout a branch and create it if it does not already exist

```sh
$ git go <branch>
```

### git wip
Starts a WIP branch saving the current moidifications to a new commit and gets you back to your working branch.

```sh
$ git wip <branch>
```

### git dc?
Aliases for ```git diff``` to bypass pager caveat

```sh
$ git d
$ git dc # Alias for git diff --cached
```

### git stat
Displays current diff stats

```sh
$ git stat
```

### git st
Alias for ```git status``` using tig

```sh
$ git st
```

### git ls
Displays a light status

```sh
$ git ls
```

### git (?:fetch|pull|push)(?:or|up)
Runs actions on remotes : 
* or : origin
* up : upstream

**Pull will be automatically rebased**

```sh
$ git fetchor
$ git fetchup

$ git pullor [<branch>]
$ git pullup [<branch>]

$ git pushor [<branch>]
$ git pushup [<branch>]
```

### git rp
Pulls a remote branch and automatically rebase

```sh
$ git rp <remote> [<branch>]
```

### git l
Alias for ```git log``` to bypass pager caveat

```sh
$ git l
```

### git graph
Displays a nice formatted graph

```sh
$ git graph
```

### git (?:g|k|t)
Runs uisefull git utilities :
* g : git gui
* k : gitk
* t : tig

[Checkout Tig homepage](http://jonas.nitro.dk/tig/)

```sh
$ git g
$ git k
$ git t
```

### git gst
Lets you quickly build a Gist

[Checkout git-gist homepage](https://github.com/defunkt/gist)

```sh
$ git gst
```

### PFlow related aliases

[Checkout PFlow homepage](https://github.com/pmsipilot/pflow)

```sh
$ git feature <start|sync|finish|...>
$ git fstart
$ git fsync
$ git ffinish
$ git fpublish
```


