FROM rust:latest
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"
LABEL Github="https://github.com/XRSec/Jupyter_Rust"
LABEL org.opencontainers.image.source="https://github.com/XRSec/Jupyter_Rust"
LABEL org.opencontainers.image.title="Jupyter_Rust"

RUN cd /root/ \
    && cargo new notebook

WORKDIR /root/notebook

COPY jupyter.sh /

RUN apt update -y \
    && apt upgrade -y \
    && apt-get install sudo fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming ncurses-bin unzip jupyter-notebook cmake build-essential locales -y \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rustup component add rust-src \
    && cargo install evcxr_jupyter cargo-edit \
    && evcxr_jupyter --install \
    && jupyter notebook --generate-config \
    && sed -i "s|# c.NotebookApp.ip = 'localhost'|c.NotebookApp.ip = '*'|g" /root/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.allow_remote_access = False|c.NotebookApp.allow_remote_access = True|g" /root/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.notebook_dir = ''|c.NotebookApp.notebook_dir = '/root/notebook'|g" /root/.jupyter/jupyter_notebook_config.py \
    && echo "zh_CN.UTF-8 UTF-8" > /etc/locale.gen \
    && sudo locale-gen \
    && chmod +x /jupyter.sh

ENTRYPOINT [ "/jupyter.sh"]

EXPOSE 8888
ENV TZ='Asia/Shanghai'
ENV LANG 'zh_CN.UTF-8'
ENV CARGO_HOME=/root/.local/lib/cargo
STOPSIGNAL SIGQUIT

CMD ["/jupyter.sh"]
