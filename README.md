# [Jupyter Go Rust](https://jupyters.vercel.app/)

![version](https://img.shields.io/badge/Date-2022_05_02-da282a) [![Docker Automated Build](https://img.shields.io/docker/automated/xrsec/jupyter?label=Build&logo=docker&style=flat-square)](https://hub.docker.com/r/xrsec/jupyter) [![Jupyter Docker Build](https://github.com/XRSec/Jupyter/actions/workflows/jupyter.yml/badge.svg)](https://github.com/XRSec/Jupyter/actions/workflows/jupyter.yml) [![version](https://img.shields.io/badge/From-google/evcxr-da282a)](https://github.com/google/evcxr)

- use [google/evcxr](https://github.com/google/evcxr)
- use [gopherdata/gophernotes](https://github.com/gopherdata/gophernotes)
- use [ohmyzsh](https://gist.github.com/XRSec/0e47c9b793887d201bab9de2a07a740c)

## Run

```bash
# GET FILE
## AliYun: registry.cn-hangzhou.aliyuncs.com/xrsec/jupyter:latest
docker run -it -d --name jupyter --rm xrsec/jupyter:latest
docker cp jupyter:/root/notebook /docker/jupyter
docker stop jupyter

docker run -it -d \
  --restart=always \
  --name jupyter \
  -v "/docker/jupyter:/root/notebook" \
  -p 8888:8888 \
  xrsec/jupyter

# Get Tocken
docker logs jupyter
# Ather Setting
click web:jupyter/upyter_notebook_config.py
```
