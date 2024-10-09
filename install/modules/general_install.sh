# install general packages
sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
sudo apt install keychain
sudo apt install pipx
pipx ensurepath
sudo apt install dconf-cli
sudo apt install gnome-terminal

# load gnome-terminal settings
dconf load /org/gnome/terminal/ < .gnome_terminal_settings