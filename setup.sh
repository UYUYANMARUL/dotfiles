#sudo apt update && sudo apt upgrade

# install git // sudo apt-get install git
#
# install curl // sudo apt install curl
#
# install brew // /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
# install exa // brew install exa
#
# install tmux // brew install tmux
#
# install tmux package manager (tpm) / git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#
# install neovim // brew install neovim
#
# brew install zoxide
#
# install gnu stow // https://github.com/aspiers/stow
#
# setup dotfiles with stow // stow .


yes | sudo pacman -S git
yes | sudo pacman -S curl
yes | /bin/bash -c "$(curl -fsSl https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/marul/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
/home/linuxbrew/.linuxbrew/bin/brew install exa
/home/linuxbrew/.linuxbrew/bin/brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
/home/linuxbrew/.linuxbrew/bin/brew install neovim
/home/linuxbrew/.linuxbrew/bin/brew install zoxide
/home/linuxbrew/.linuxbrew/bin/brew install stow
localectl set-locale LANG=en_US.UTF-8
stow .
