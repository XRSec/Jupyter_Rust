FROM rust:latest
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"
LABEL Github="https://github.com/XRSec/Jupyter_Rust"
LABEL org.opencontainers.image.source="https://github.com/XRSec/Jupyter_Rust"
LABEL org.opencontainers.image.title="Jupyter_Rust"

RUN useradd -m jupyter

WORKDIR /home/jupyter

COPY jupyter.sh /

RUN apt update -y \
    && apt upgrade -y \
    && mkdir /home/jupyter/notebooks \
    && apt-get install sudo fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming ncurses-bin unzip jupyter-notebook cmake build-essential -y \
    && apt clean -y \
    && rustup component add rust-src \
    && cargo install evcxr_jupyter cargo-edit \
    && chown jupyter:jupyter /home/jupyter/notebooks \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && chmod +x /jupyter.sh

USER 1000:1000

RUN evcxr_jupyter --install \
    && jupyter notebook --generate-config \
    && sed -i "s|# c.NotebookApp.ip = 'localhost'|c.NotebookApp.ip = '*'|g" /home/jupyter/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.allow_remote_access = False|c.NotebookApp.allow_remote_access = True|g" /home/jupyter/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.notebook_dir = ''|c.NotebookApp.notebook_dir = '/home/jupyter/notebooks'|g" /home/jupyter/.jupyter/jupyter_notebook_config.py

ENTRYPOINT [ "/jupyter.sh"]

EXPOSE 8888
ENV TZ='Asia/Shanghai'
ENV LANG 'zh_CN.UTF-8'
ENV CARGO_HOME=/home/jupyter/.local/lib/cargo
STOPSIGNAL SIGQUIT

CMD ["/jupyter.sh"]
