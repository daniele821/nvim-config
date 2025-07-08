FROM archlinux

# install needed packages
RUN pacman -Syu --noconfirm --needed lsd ripgrep bat git less bash-completion \
    neovim git unzip wget ripgrep tree-sitter-cli base-devel nodejs npm python3 rustup go && \
    pacman -Scc --noconfirm

# initialize neovim
COPY . /root/.config/nvim
RUN rm -rf /root/.config/nvim/.git  && \
    nvim --headless +StarterPack +qa

# initialize bash
COPY ./image/bashrc /root/.bashrc
