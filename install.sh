curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin
oh-my-posh font install --user FiraCode

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# merge if zshrc already exists
touch ~/.zshrc
sed -i 's\plugins=\plugins+=\g' ~/.zshrc
cat .zshrc ~/.zshrc > tmp
mv tmp ~/.zshrc

ln -s .gitconfig ~/.gitconfig
