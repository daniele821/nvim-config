FROM archlinux
RUN pacman -Syu --noconfirm --needed neovim git unzip wget tree-sitter-cli base-devel nodejs python3 npm
RUN git clone https://github.com/daniele821/nvim-config /root/.config/nvim 
RUN git -C /root/.config/nvim switch complete 
RUN nvim --headless +StarterPack +qa
