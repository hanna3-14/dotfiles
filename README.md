# dotfiles

these are my dotfiles, tracked with a bare git repository as described [here](https://atlassian.com/git/tutorials/dotfiles)

## initialize the repository for your dotfiles
- `git init --bare $HOME/.dotfiles` init a bare git repository in your home directory
- `alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'` create an alias to track dotfiles
- `config config --local status.showUntrackedFiles no`
- permanently adding the alias to fish by adding the following into `.config/fish/functions/config.fish`
```
functions config
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv;
end
```
- `echo ".dotfiles" >> .gitignore` the source repository has to ignore the folders where you'll clone it

## install dotfiles onto a new system
- `alias cofig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'` create an alias to track dotfiles
- `git clone --bare <git-repo-url> $HOME/.dotfiles` clone dotfiles into a bare repoitory
- `alias cofig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'` define the alias in the current shell scope
- `config checkout`
- `config config --local status.showUntrackedFiles no`