#!/bin/bash

APT_COMMAND="apt"
if [ -x "$(command -v apt-fast)" ]; then
    APT_COMMAND="apt-fast"
fi

TARGET_ZSHRC="~/.zshrc"
TARGET_BASHRC="~/.bashrc"

#
# Stage 1: Clone ASDF to homedir
#

# Install dependencies (git)
SHOULD_INSTALL_GIT="true"
install_git() {
    if [$SHOULD_INSTALL_GIT == "true"]; then
        sudo $APT_COMMAND install -y git
    fi
}
install_git

# Clone asdf to homedir
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0

# Install asdf to .zshrc
echo '. "$HOME/.asdf/asdf.sh"' >> $TARGET_ZSHRC
echo '# append completions to fpath' >> $TARGET_ZSHRC
echo 'fpath=(${ASDF_DIR}/completions $fpath)' >> $TARGET_ZSHRC
echo "# initialise completions with ZSH's compinit" >> $TARGET_ZSHRC
echo 'autoload -Uz compinit && compinit' >> $TARGET_ZSHRC
# Install asdf to .bashrc
echo '. "$HOME/.asdf/asdf.sh"' >> $TARGET_BASHRC
echo '. "$HOME/.asdf/completions/asdf.bash"' >> $TARGET_BASHRC

#
# Stage 2: Install asdf ruby plugin and dependencies
#

RUBY_ASDF_NAME="ruby"
RUBY_ASDF_VERSION="latest"
RUBY_APT_DEPS="libyaml-dev libssl-dev"

asdf plugin add $RUBY_ASDF_NAME
sudo $APT_COMMAND update -y
sudo $APT_COMMAND install -y $RUBY_APT_DEPS
asdf install ruby $RUBY_ASDF_VERSION

#
# Stage 3: Install asdf postgres plugin and dependencies
#

POSTGRES_ASDF_NAME="postgres"
POSTGRES_APT_DEPS="libreadline-dev"
POSTGRES_ASDF_VERSION="latest"

asdf plugin add $POSTGRES_ASDF_NAME
sudo $APT_COMMAND update -y
sudo $APT_COMMAND install -y $POSTGRES_APT_DEPS
asdf install postgres $POSTGRES_ASDF_VERSION