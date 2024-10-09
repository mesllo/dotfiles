
# Step to address WSL2 Ubuntu 22.04 LTS issue with iptables:
# According to https://crapts.org/2022/05/15/install-docker-in-wsl2-with-ubuntu-22-04-lts
# we need to install iptables-legacy
sudo update-alternatives --config iptables 

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt update
sudo apt upgrade
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install docker:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Test that it works:
sudo docker run hello-world

# The docker daemon is a background process that manages and controls
# all docker images, containers, volumes, etc). It binds to a Unix socket
# not a TCP port, and therefore the root user owns it. Since docker binds
# to a Unix socket which the root user owns, other users have to use sudo
# to access it. To bypass sudo, we can create a Unix group and add the
# respective user to it:
sudo groupadd docker
sudo usermod -aG docker $USER