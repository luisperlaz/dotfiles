dotfiles
========

### vimrc installation

1. Install dein from: https://github.com/Shougo/dein.vim
```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh                                                                          
sh ./installer.sh ~/.vim/dein                                                                
```

2. Install fzf:
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

3. Install nodejs if not available(> 14.14)
```
sudo curl -sL install-node.vercel.app/lts | sudo bash
```

4. After starting vim, run the following:

```
:CocInstall coc-pyright
:CocInstall coc-snippets
:CocInstall coc-word
```
