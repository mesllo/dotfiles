# dotfiles

Finally got round to maintaining my own dotfile environment. It's far from perfect, but it's a start! Feel free to clone/fork/whatever but use at your own risk!

## Installation

1. If you're on a new machine, first create a new SSH key on Github by following the steps below (ensure the correct name of the ssh key as is on `.bashrc`).

2. `git init` on `~`

3. Point the remote to the `dotfiles` repo:
```
git remote add origin [repo-ssh-url]
```

4. `git pull`

5. Now that the dotfiles and installation modules are available, everything you need such as keychain, Poetry, and Docker can be installed by simply running:
```
source ./install/install_all.sh
```

6. Untrack any folders/files that you don't want tracked by git (even though they're in `.gitignore`)
```
git rm -r --cached --ignore-unmatch path_to_your_folder/
```

## Useful stuff

### Working on a gnome terminal instead

Run a gnome terminal by

```
gnome-terminal &
```

Export gnome terminal settings to a config file by running

```
dconf dump /org/gnome/terminal/ > .gnome_terminal_settings
```

Load gnome terminal settings from config file by running

```
dconf load /org/gnome/terminal/ < .gnome_terminal_settings
```

## Prickly stuff

### SSH Keys

Every time this dotfile env is loaded onto a new machine it'll try look for the default
ssh key that is defined on `bashrc` with `keychain`. Of course, this'll give an error message until the ssh key is added accordingly. 

1. For sshing into Github, first create a new key pair with `ssh-keygen`.

2. Add the newly created public key to Github.

3. Run the ssh-agent by doing (however, it's already ran by default via `keychain` on `.bashrc`):
```
eval "$(ssh-agent -s)"
```

4. Add the key to the ssh-agent (it's already added by default via `keychain` on `.bashrc`):
```
ssh-add ~/.ssh/your_key
```
