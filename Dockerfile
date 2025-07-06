FROM archlinux
RUN pacman -Syu --noconfirm --needed neovim git unzip python3 npm
COPY . /root/.config/nvim
WORKDIR /root
RUN nvim --headless +StarterPack +qa
