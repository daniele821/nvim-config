FROM archlinux
COPY ./bashrc /root/.bashrc
COPY .. /root/.config/nvim
RUN pacman -Syu --noconfirm --needed lsd ripgrep bat git less bash-completion \
    neovim git unzip wget ripgrep tree-sitter-cli base-devel nodejs npm python3 rustup go && \
    pacman -Scc --noconfirm
RUN rm -rf /root/.config/nvim/.git  && \
    nvim --headless +StarterPack +qa && \
