FROM archlinux
RUN pacman -Syu --noconfirm --needed neovim git unzip wget base-devel
RUN git clone https://github.com/daniele821/nvim-config /root/.config/nvim 
RUN git -C /root/.config/nvim switch complete 
