FROM archlinux
RUN pacman -Syu --noconfirm --needed neovim git unzip wget tree-sitter-cli
COPY . /root/.config/nvim
WORKDIR /root
RUN nvim --headless +StarterPack +qa
