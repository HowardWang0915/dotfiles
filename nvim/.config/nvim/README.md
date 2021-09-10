# .vimrc
This is the configuration for my neovim

First install `vim` or `nvim` on your system(This repo was used under `nvim`, it may not work for `vim`).
When using neovim, rename repo name `.vimrc` to `nvim` and put it under your `.config` directory. Remember to do a backup of the old configuration!

## How to use plugins
First go to `/plugins/plugins.vim` and check for every plugin, comment out the ones you don't want, also go to `/plugconf/plugconf.vim` comment out the corresponding plugin.
The plugins are:
* coc.vim - A vscode like LSP that supports intellisence and autocomplete for multiple languages. Must have.
* nerdcommenter - Comment your code as fast as possible.
* vim-surround - Forget your brackets?? Tired of html tags? Use this!!
* vim-repeat - A support plugin for vim-surround, supporting the '.' command.
* fzf.vim - A fuzzy finder for vim with ripgrep and git integration. Must have.
* vim-fugitive - A git wrapper for vim, so awesome it should be illegal.
* gogo.vim - Want to stay focused? Use this to turn off distractions!
* vim-airline - A beautiful vim status line using powerline. If you don't have powerline installed comment this out
* gruvbox - The best color scheme of all time, so beautiful.
* vim-devicons - Nerd font, icons, making your vim asthetic.
* vim-startify - A beautiful starting page for vim, supports session storing.
* vim-indentLine - A plugin to show the indent level.
* rainbow - Writing some C/C++ code? Distinct the brackets with different colors.

If you like all the plugins run 
```
sh ./setup.sh
``` 
And you are good to go! Note: the setup does not include coc language packages and ripgrep packages, this is up to you.\
The default `<leader>` key is set to `space`(you can think of this like an activation key). You can change this in `/general/settings.vim`

If you are intrested with detailed settings, please look below.
### Vim Plug
First, use vim plug to manage your plugins, install it via
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
If failed, go to [here](https://github.com/junegunn/vim-plug) to check if there are any updates.
Now goto `plugins/plugins.vim` to check
### COC(autocomplete LSP)
#### Setup
COC is a strong LSP server for any programming languages. 
Original [github](https://github.com/neoclide/coc.nvim) page is here.
First you will need node.js installed on your system
```
curl -sL install-node.now.sh/lts | bash
```
If you don't have root access, download node manually and specify the path in `plugconf/coc.vim` with `let g:coc_node_path = '/path/to/node'`\
At default I automatic install C/C++ and python server and coc-explorer if you run `:CocInstall` inside of vim, you can add any other languages by searching in the [github](https://github.com/neoclide/coc.vim).\
\
If you want to use the autocomplete with python, remember to: ```
```
pip install jedi
```
#### Mappings
* `gd`: go to definition.
* `gr`: go to references(show all where functions have been called)
* `gf`: go to file, if a path of a file is specified inside the text.
* `rn`: rename variable through out the project.(But need to save all files manually)
* `K`: Show definition in floating window.
* `tab` for completion floating menu.
Useful tips:
* `Ctrl-o` to go back.(Supports project-wise hopping)
* `Ctrl-i` to go forward again.
* `Ctrl-6` to swap between two files.
Also I installed a file tree by coc(coc-explorer), but it is a little bit unstable, still usable.
* `<leader>e`: to toggle coc-explorer.
* `Ctrl-w Ctrl-j` and `Ctrl-w Ctrl-k` to hop between windows.

### FZF
FZF is essential for navigating inside of a large project. [Github](https://github.com/junegunn/fzf.vim). It is way better than using a file tree.\
To enable ripgrep(the ability to search content inside a file) for fuzzy finding. For Arch linux, remember to 
```
yay -S ripgrep
```
Or for Ubuntu
``` 
sudo apt-get isntall ripgrep
```

#### Mappings
To maximize the power of fzf, always start vim at the parent folder of a project.
* `<leader>ff`: Fuzzy search recursively at the current file level.
* `<leader>gf`: Search for all git file(Only for git projects).
* `<leader>rg`: Ripgrep, find text inside of all files recursively(remember to start vim at parent level!).
In side every fzf window, use <Ctrl-j> and <Ctrl-k> to go up and down. \
\
For ripgrep, it is integrated with quick-fix list, it is extremely powerful if you have **TODO**'s in your comment. Use tab to select or unselect items of ripgrep, 
or `<Alt-a>` to select all or `<Alt-d>` to unselect all. Once you pressed `Enter`, every instance you selected will go inside the `Quick Fix List`.\
\
To open and close Quick-fix list, press <Ctrl-q> to toggle. To walk through every instane inside the `Quick Fix List`, press <Ctrl-j> and <Ctrl-k>.\
To clear the `Quick Fix List`, enter `:cexpr []` in the vim command.

### Vim-airline
You can disable airline(status bar) if you don't have powerline installed on your system
