FROM archlinux
RUN pacman -Syu --noconfirm --needed \
    neovim git unzip wget tree-sitter-cli base-devel nodejs npm python3 && \
    git clone https://github.com/daniele821/nvim-config /root/.config/nvim  && \
    git -C /root/.config/nvim switch complete  && \
    nvim --headless +StarterPack +qa && \
    pacman -Scc --noconfirm
