# dotfiles

## ZSH Theme

**This theme is highly inspired by [jeremyFreeAgent's Powerline theme](https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme) and by [agnoster's one](https://gist.github.com/3712874)**

_Here is a quick demo of this theme : http://ascii.io/a/1774_

In this repository, you'll find my ZSH theme.
This theme is really cutomizable as I use it in different environments (Ubuntu, OS X, Desktop, Server). The only things that are not easilly customizable at the moment are the segment colors.

### How to use

To use this theme, you'll need to install [Oh My ZSH](https://github.com/robbyrussell/oh-my-zsh) and put the content of this repository in your home directory.
Then restart your terminal session and everything shold be OK.

### How to customize

There are several things to customize in this theme :
* Every symbol used in the prompt : check out the variables list at the [top of the theme file](https://github.com/jubianchi/dotfiles/blob/master/.oh-my-zsh/themes/jubianchi.zsh-theme#L3-L15)
* Prompt components : check out how to do this in the [.zshrc file](https://github.com/jubianchi/dotfiles/blob/master/.zshrc#L26-L27)

You can also define your own component and add them to your prompt :
* A component is a simple function with a name beginning with ```prompt_```
* It takes at least one argument which is a callback to the segment renderer function (this is needed to be able to put the segment at the right or left prompt)

Check out examples in [the theme file](https://github.com/jubianchi/dotfiles/blob/master/.oh-my-zsh/themes/jubianchi.zsh-theme#L141-L147)

### Supported tools
* PHP
* Vagrant
* Git
* Screen
