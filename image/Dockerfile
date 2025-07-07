FROM archlinux
COPY ./bashrc /root/.bashrc
RUN pacman -Syu --noconfirm --needed zoxide lsd ripgrep bat git && \
    pacman -Syu --noconfirm --needed neovim git unzip wget ripgrep tree-sitter-cli base-devel nodejs npm python3 && \
    git clone https://github.com/daniele821/nvim-config /root/.config/nvim  && \
    git -C /root/.config/nvim switch complete  && \
    nvim --headless +StarterPack +qa && \
    pacman -Scc --noconfirm
WORKDIR /root
