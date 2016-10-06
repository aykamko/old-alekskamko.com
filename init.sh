#!/bin/bash
#
# Run with: bash <(wget -O - www.alekskamko.com/init.sh)
#

os=$(uname)
if echo "$os" | grep -iq "linux"; then
    if ! hash apt-get 2>/dev/null && hash yum 2>/dev/null; then
        sudo ln -s $(which yum) /usr/bin/apt-get
    fi
    sudo apt-get update
    sudo apt-get install -y git
elif "$os" | grep -iq "darwin"; then
    echo
    # TODO
fi

git clone https://github.com/aykamko/dotfiles ~/dotfiles
pushd ~/dotfiles
./install
popd

if echo "$os" | grep -iq "linux"; then
    if ! hash apt-get 2>/dev/null && hash yum 2>/dev/null; then
        sudo rm -f /usr/bin/apt-get
    fi
fi

YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)
echo "${YELLOW}"
echo "################################################################"
echo "# Please logout and log back in to see changes to take effect! #"
echo "################################################################"
echo "${RESET}"
