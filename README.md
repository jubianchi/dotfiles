# Example usage

```sh
$ mkdir my-repository
$ git make php
$ git radd origin ghs:me/my-repository
$ git pushor master
$ git go new-feature

# On branch new-feature
# Commit, commit, commit...
# Sleep

$ git pullor master

# Commit, commit, commit...

$ git finish master

# Rebase, squash, ...
# On branch master

$ git pushor master

```

# Aliases

* [URLs](#urls)
	* [ghs:](#ghs)
	* [gh:](#gh)
	* [gists:](#gists)
	* [bbs:](#bbs)
	* [bb:](#bb)
* [Commands](#commands)
	* [Repository](#repository)
		* [cleanup](#git-cleanup)
		* [ignore](#git-ignore)
		* [make](#git-make)
	* [Configuration](#configuration)
		* [aliases](#git-aliases)
	* [Staging](#staging)
		* [addall](#git-addall)
		* [patch](#git-patch)
		* [unadd](#git-unadd)
	* [Commit](#commit)
		* [amend](#git-amend)
		* [cp](#git-cp)
		* [undo](#git-undo)
	* [Branching](#branching)
		* [br/bra/brr/brn](#git-brarn)
		* [cb](#git-cb)
		* [pwd](#git-pwd)
	* [Workflow](#workflow)
		* [develop/master](#git-developmaster)
		* [go](#git-go)
		* [finish](#git-finish)
		* [wip](#git-wip)
	* [Status](#status)
		* [d/dc](#git-dc)
		* [stat](#git-stat)
		* [st](#git-st)
		* [ls](#git-ls)
	* [Remote](#remote)
		* [fetchor/fetchup/pullor/pullup/pushor/pushup](#git-fetchpullpushorup)
		* [rp](#git-rp)
		* [radd](#git-radd)
	* [Log](#log)
		* [l](#git-l)
		* [graph](#git-graph)
	* [Utilities](#utilities)
		* [g/k/t](#git-gkt)
		* [gist](#git-gist)
	* [PFlow](#pflow)
	* [Github](#github)

## URLs

### ghs:

Alias for Github clone URL (SSH protocol) :

```sh
$ git clone ghs:jubianchi/atoum
# Shortcut for git clone git@github.com:jubianchi/atoum
```

### gh:

Alias for Github clone URL (Git readonly protocol) :

```sh
$ git clone gh:jubianchi/atoum
# Shortcut for git clone git://github.com/jubianchi/atoum
```

### gists:

Alias for Gist clone URL (SSH protocol) :

```sh
$ git clone gists:a52e82e9ccc25449c325.git
# Shortcut for git clone git@gist.github.com:a52e82e9ccc25449c325.git
```

### bbs:

Alias for BitBucket clone URL (SSH protocol) :

```sh
$ git clone bbs:jubianchi/atoum
# Shortcut for git clone git@bitbucket.org:jubianchi/atoum
```

### bb:

Alias for BitBucket clone URL (HTTPS readonly protocol) :

```sh
$ git clone bb:jubianchi/atoum
# Shortcut for git clone https://bitbucket.org/jubianchi/atoum
```

## Commands

### Repository

#### git cleanup

Cleans up the repository by pruning remote, running GC and clearing stash

```sh
$ git cleanup [<remote>] (Default: origin)
```

#### git ignore

Adds an entry to the .gitignore file

```sh
$ git ignore <entry>
```

#### git make

Create a new empty repository with an empty initial commit.
This alias lets you chosse a template to init your repository (one of php, default)

```sh
$ git make [<initial-commit-message>] (Default: Initial commit) [<template>]
```

### Configuration

#### git aliases

Lists all available aliases

```sh
$ git aliases
```

### Staging

#### git addall

Adds all files that are not staged and displays a light status

```sh
$ git addall
```
	
#### git patch

Alias for ```git add --patch```

```sh
$ git patch
```

#### git unadd

Unstages file

```sh
$ git unadd <file[, file, …]>
```

### Commit

#### git amend

Amends the last commits keeping its original message

Alias for ```git commit --amend -C HEAD```

```sh
$ git amend
```

#### git cp

Cherry-picks a commit and edit  message

Alias for ```git cherry-pick -ex```

```sh
$ git cp <sha1>
```

#### git undo

Resets the last commit keeping the modifications (soft reset) and displays a light status

```sh
$ git undo
```

### Branching

#### git br(?:|a|r|n)

Displays branches list

Aliases for ```git branch```

```sh
# Displays local branches
$ git br
# Displays all branches  (local + remote)	
$ git bra
# Displays remote branches
$ git brr
# Displays all (local + remote) not merged branches
$ git brn
```

#### git cb

Checkout a new branch

Aliases for ```git checkout -b```

```sh
$ git cb <branch>
```
	
#### git pwd

Displays the name of the current branch

```sh
$ git pwd
```	

### Workflow

#### git (?:develop|master)

Checkout the develop or master branch

Aliases for ```git checkout```

```sh
$ git master
$ git develop
```

_You could have one alias for each [long running branch](http://git-scm.com/book/en/Git-Branching-Branching-Workflows#Long-Running-Branches) in your repositories configuration file_

#### git go

Creates (if it does not exist) and checkout a branch

```sh
$ git go <branch>
```

#### git finish

Finishes the current topic branch by interactively rebasing its commits and merging it into another branch

```sh
$ git finish <branch>
```

#### git wip

Starts a WIP branch saving the current moidifications to a new commit and gets you back to your working branch.

```sh
$ git wip <branch>
```

### Status

#### git dc?

Aliases for ```git diff``` to bypass pager caveat

```sh
$ git d
# Alias for git diff --cached
$ git dc 
```

#### git stat

Displays current diff stats

Alias ```git diff --stat```

```sh
$ git stat
```

#### git st

Displays an interactive status screen

Alias for ```git status``` using tig

```sh
$ git st
```

#### git ls

Displays a light status

```sh
$ git ls
```

### Remote

**Pulls will be automatically rebased when using these aliases**

#### git (?:fetch|pull|push)(?:or|up)

Runs actions on remotes : 
* or : origin
* up : upstream

Aliases for ```git (?:fetch|pull|push)``` 

```sh
$ git fetchor
$ git fetchup

$ git pullor [<branch>]
$ git pullup [<branch>]

$ git pushor [<branch>]
$ git pushup [<branch>]
```

#### git rp

Pulls a remote branch and automatically rebase

Alias for ```git pull --rebase```

```sh
$ git rp <remote> [<branch>]
```

#### git radd

Adds a new remote

Alias for ```git remote add```

```sh
$ git radd <name> <url>
	```

### Log

#### git l

Alias for ```git log``` to bypass pager caveat

```sh
$ git l
```

#### git graph

Displays a nice formatted graph

Alias for ```git log```

```sh
$ git graph
```

### Utilities

#### git (?:g|k|t)

Runs usefull git utilities :
* g : Alias for ```git gui```
* k : Alias for ```gitk```
* t : Alias for ```tig```

[Check out Tig homepage](http://jonas.nitro.dk/tig/)

```sh
$ git g
$ git k
$ git t
```

#### git gist

Lets you quickly build a Gist

[Check out git-gist homepage](https://github.com/defunkt/gist)

```sh
$ git gist
```

### PFlow

[Check out PFlow homepage](https://github.com/pmsipilot/pflow)

```sh
$ git feature <start|sync|finish|...>
$ git fstart
$ git fsync
$ git ffinish
$ git fpublish
```

### Github

**If you work a lot with Github, check out [defunkt/hub](https://github.com/defunkt/hub)  which is a great tool integrating Github's features to git**

