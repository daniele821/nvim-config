FROM fedora

# install needed packages
RUN dnf install -y lsd ripgrep bat git bash-completion \
    neovim git unzip wget ripgrep tree-sitter-cli nodejs npm python3 golang && \
    dnf autoremove -y && dnf clean all

# initialize neovim
ENV EDITOR="nvim" PYTHONDONTWRITEBYTECODE="true" PYTHON_HISTORY="/dev/null" \ 
    NODE_REPL_HISTORY="/dev/null" GOPATH="$HOME/.local/share/go" \
    RUSTUP_HOME="$HOME/.local/share/rustup" CARGO_HOME="$HOME/.local/share/cargo"

COPY . /root/.config/nvim
RUN rm -rf /root/.config/nvim/.git  && \
    nvim --headless +StarterPack +qa

# initialize bash
COPY ./image/bashrc /tmp/bashrc
RUN cat /tmp/bashrc >> /root/.bashrc && rm /tmp/bashrc

# set initial directory
WORKDIR /root
