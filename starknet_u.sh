#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
	echo ''
else
  sudo apt install curl -y < "/dev/null"
fi
curl -s https://api.nodes.guru/logo.sh | bash
echo "==================================================="
sleep 2
sudo apt update && sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update && sudo apt install curl git tmux python3.10 python3.10-venv python3.10-dev build-essential libgmp-dev pkg-config libssl-dev -y
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
rustup update stable --force

cd ~/pathfinder
rustup update
git pull
git fetch --all
git checkout v0.7.0
source $HOME/.cargo/env
cargo build --release --bin pathfinder
mv ~/pathfinder/target/release/pathfinder /usr/local/bin/
cd py
python3.10 -m venv .venv
source .venv/bin/activate
PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
pip install --upgrade pip
systemctl restart starknetd


echo -e "\e[32mYour node version\e[39m" $(pathfinder -V)
