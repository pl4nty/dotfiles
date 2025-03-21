#!/bin/bash

mkdir -p ~/bin
export PATH="$PATH:$HOME/bin"
curl -s --insecure https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin
oh-my-posh font install FiraCode

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# merge if zshrc already exists
touch ~/.zshrc
sed -i 's\plugins=\plugins+=\g' ~/.zshrc
cat .zshrc ~/.zshrc > tmp
mv tmp ~/.zshrc

ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/devicie.gitconfig ~/devicie.gitconfig

curl -L https://github.com/cli/cli/releases/latest/download/gh_2.68.1_linux_amd64.tar.gz | \
  tar xzf - -C /tmp && \
  mv /tmp/gh_2.68.1_linux_amd64/bin/gh ~/bin/
rm -r /tmp/gh_2.68.1_linux_amd64
chmod +x ~/bin/gh
