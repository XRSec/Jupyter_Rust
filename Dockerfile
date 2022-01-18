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
COPY README.ipynb /root/notebook/

RUN apt update -y \
    && apt upgrade -y \
    && apt-get install sudo fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming ncurses-bin unzip jupyter-notebook cmake build-essential locales zsh git util-linux -y \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && /usr/bin/pip install jupyterlab \
    && /usr/bin/pip install jupyterlab-language-pack-zh-CN jupyter_contrib_nbextensions \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN rustup component add rust-src \
    && cargo install evcxr_jupyter cargo-edit \
    && evcxr_jupyter --install \
    && jupyter notebook --generate-config \
    && jupyter contrib nbextension install

RUN sed -i "s|# c.NotebookApp.ip = 'localhost'|c.NotebookApp.ip = '*'|g" /root/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.allow_remote_access = False|c.NotebookApp.allow_remote_access = True|g" /root/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.notebook_dir = ''|c.NotebookApp.notebook_dir = '/root/notebook'|g" /root/.jupyter/jupyter_notebook_config.py \
    && sed -i "s|# c.NotebookApp.terminado_settings = {}|c.NotebookApp.terminado_settings = {'shell_command': ['/bin/zsh']}|g" /root/.jupyter/jupyter_notebook_config.py \
    && echo "zh_CN.UTF-8 UTF-8" > /etc/locale.gen \
    && sudo locale-gen \
    && chmod +x /jupyter.sh
    
RUN chsh -s /bin/zsh \
    && zsh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && sed -i "s/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions docker kubectl brew golang history nmap node npm pip pipenv pyenv pylint python screen sublime)/g" ~/.zshrc


ENTRYPOINT [ "/jupyter.sh"]

EXPOSE 8888
ENV TZ='Asia/Shanghai'
ENV LANG 'zh_CN.UTF-8'
ENV CARGO_HOME=/root/.local/lib/cargo
STOPSIGNAL SIGQUIT

CMD ["/jupyter.sh"]
