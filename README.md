# Jupyter Rust

![version](https://img.shields.io/badge/Date-2022_01_17-da282a) [![Docker Automated Build](https://img.shields.io/docker/automated/xrsec/jupyter_rust?label=Build&logo=docker&style=flat-square)](https://hub.docker.com/r/xrsec/jupyter_rust) [![Jupyter Docker Build](https://github.com/XRSec/Jupyter_Rust/actions/workflows/jupyter.yml/badge.svg)](https://github.com/XRSec/Jupyter_Rust/actions/workflows/jupyter.yml) [![version](https://img.shields.io/badge/From-google/evcxr-da282a)](https://github.com/google/evcxr)

- use [google/evcxr](https://github.com/google/evcxr)

## Run

```bash
docker run -it -d \
--restart \
--name jupyter \
-v "/docker/jupyter:/root" \
-p 8888:8888 \
jupyter/scipy-notebook
```

<hr>

