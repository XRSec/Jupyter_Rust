FROM ubuntu:latest
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"
LABEL Github="https://github.com/XRSec/"
LABEL org.opencontainers.image.source="https://github.com/XRSec/"
LABEL org.opencontainers.image.title="Jupyter"

RUN mkdir /root/notebook
WORKDIR /root/notebook
ENV TZ Asia/Shanghai
SHELL [ "/bin/bash" , "-c" ]

COPY README.ipynb /root/notebook/

# INIT
RUN apt-get -qq update \
    && apt-get -qq upgrade \
    && apt-get -qq install apt-utils \
    && apt-get -qq install \
        tzdata \
        locales \
    && ln -sf "/usr/share/zoneinfo/${TZ}" /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && ln -sf "$(which bash)" "$(which sh)"

RUN apt-get -qq install \
        fonts-droid-fallback \
        ttf-wqy-zenhei \
        ttf-wqy-microhei \
        fonts-arphic-ukai \
        fonts-arphic-uming \
        language-pack-zh-hans \
        ncurses-bin \
        unzip \
        cmake \
        build-essential \
        gcc \
        libssl-dev \
        pkg-config \
        zsh \
        git \
        curl \
        sudo \
        util-linux \
        apt-transport-https \
        ca-certificates \
        # JUPYTER
        jupyter-notebook \
        python3-pip \
        # Golang
        golang \
    && apt-get -qq clean \
    # GOLANG
    && go install github.com/cweill/gotests/gotests@latest \
    && go install github.com/fatih/gomodifytags@latest \
    && go install github.com/josharian/impl@latest \
    && go install github.com/haya14busa/goplay/cmd/goplay@latest \
    && go install github.com/go-delve/delve/cmd/dlv@latest \
    && go install honnef.co/go/tools/cmd/staticcheck@latest \
    && go install golang.org/x/tools/gopls@latest \
    # PIP
    && ln -sf /usr/bin/pip3 /usr/bin/pip \
    && pip install jupyterlab \
    && pip install jupyterlab-language-pack-zh-CN jupyter_contrib_nbextensions \
    && rm -rf /var/lib/apt/lists/* \
    # RUST
    && bash <(curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf) -y

# ENV
RUN echo "export PATH=\$PATH:/root/go/bin/" >> /root/.bashrc \
    && echo "export PATH=\$PATH:$HOME/.cargo/bin" >> /root/.bashrc \
    && export PATH="\$PATH:/root/go/bin/" \
    && export PATH="\$PATH:$HOME/.cargo/bin" \
    && echo "$PATH"

# Rust
RUN /root/.cargo/bin/rustup component add rust-src \
    && /root/.cargo/bin/cargo install evcxr_jupyter cargo-edit \
    && /root/.cargo/bin/evcxr_jupyter --install \
    && jupyter notebook --generate-config \
    && jupyter contrib nbextension install

# Go
RUN env GO111MODULE=on go install github.com/gopherdata/gophernotes@latest \
    && mkdir -p ~/.local/share/jupyter/kernels/gophernotes \
    && cd ~/.local/share/jupyter/kernels/gophernotes \
    && cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.4/kernel/*  "." \
    && chmod +w ./kernel.json # in case copied kernel.json has no write permission \
    && sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json

# Jupyter
RUN sed -i "s|# c.NotebookApp.ip = 'localhost'|c.NotebookApp.ip = '*'|g" /root/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.allow_remote_access = False|c.NotebookApp.allow_remote_access = True|g" /root/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.notebook_dir = ''|c.NotebookApp.notebook_dir = '/root/notebook'|g" /root/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.terminado_settings = {}|c.NotebookApp.terminado_settings = {'shell_command': ['/bin/zsh']}|g" /root/.jupyter/jupyter_notebook_config.py \
    && echo "zh_CN.UTF-8 UTF-8" > /etc/locale.gen \
    && sudo locale-gen

# ZSH
RUN curl -s https://gist.githubusercontent.com/XRSec/0e47c9b793887d201bab9de2a07a740c/raw/f69344ffc89fd5319cb3aecbb36116ed6c31543e/zsh_init.sh | bash -

EXPOSE 8888
ENV TZ='Asia/Shanghai'
ENV LANG 'zh_CN.UTF-8'
ENV CARGO_HOME=/root/.local/lib/cargo
STOPSIGNAL SIGQUIT

CMD [ "/usr/bin/jupyter-notebook", "--no-browser", "--allow-root", "--ip=0.0.0.0", "--config=/root/.jupyter/jupyter_notebook_config.py"]