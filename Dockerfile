FROM rust:latest
LABEL maintainer="xrsec"
LABEL mail="troy@zygd.site"
LABEL Github="https://github.com/XRSec/AWVS14-Update"
LABEL org.opencontainers.image.source="https://github.com/XRSec/AWVS14-Update"
LABEL org.opencontainers.image.title="AWVS14-Update"

COPY jupyter.sh /

RUN apt update -y \
    && apt upgrade -y \
    && apt-get install sudo fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming ncurses-bin unzip jupyter-notebook cmake build-essential -y \
    && apt clean -y \
    && rustup component add rust-src \
    && cargo install evcxr_jupyter \
    && evcxr_jupyter --install \
    && chmod +x /jupyter.sh

ENTRYPOINT [ "/jupyter.sh"]

EXPOSE 8888
ENV TZ='Asia/Shanghai'
ENV LANG 'zh_CN.UTF-8'
STOPSIGNAL SIGQUIT

CMD ["/jupyter.sh"]