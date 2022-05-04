{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "directed-subsection",
   "metadata": {},
   "source": [
    "# [Jupyter Go Rust](https://jupyters.vercel.app/)\n",
    "\n",
    "![version](https://img.shields.io/badge/Date-2022_05_02-da282a) [![Docker Automated Build](https://img.shields.io/docker/automated/xrsec/jupyter?label=Build&logo=docker&style=flat-square)](https://hub.docker.com/r/xrsec/jupyter) [![Jupyter Docker Build](https://github.com/XRSec/Jupyter/actions/workflows/jupyter.yml/badge.svg)](https://github.com/XRSec/Jupyter/actions/workflows/jupyter.yml) [![version](https://img.shields.io/badge/From-google/evcxr-da282a)](https://github.com/google/evcxr)\n",
    "\n",
    "- use [google/evcxr](https://github.com/google/evcxr)\n",
    "- use [gopherdata/gophernotes](https://github.com/gopherdata/gophernotes)\n",
    "- use [ohmyzsh](https://gist.github.com/XRSec/0e47c9b793887d201bab9de2a07a740c)\n",
    "\n",
    "## Run\n",
    "\n",
    "```bash\n",
    "# GET FILE\n",
    "## AliYun: registry.cn-hangzhou.aliyuncs.com/xrsec/jupyter:latest\n",
    "docker run -it -d --name jupyter --rm xrsec/jupyter:latest\n",
    "docker cp jupyter:/root/notebook /docker/jupyter\n",
    "docker stop jupyter\n",
    "\n",
    "# RUN\n",
    "\n",
    "docker run -it -d \\\n",
    "  --restart=always \\\n",
    "  --name jupyter \\\n",
    "  -v \"/docker/jupyter:/root/notebook\" \\\n",
    "  -p 8888:8888 \\\n",
    "  xrsec/jupyter\n",
    "\n",
    "# Get Tocken\n",
    "docker logs jupyter\n",
    "# Ather Setting\n",
    "## jupyter => new => terminals\n",
    "cp /root/.jupyter/jupyter_notebook_config.py /root/notebook/jupyter_notebook_config.py\n",
    "## Edit & Save\n",
    "cp -rf /root/notebook/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py\n",
    "```"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "comparative-member",
   "metadata": {},
   "source": [
    "## Play Game"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "optimum-dominant",
   "metadata": {
    "scrolled": true,
    "vscode": {
     "languageId": "rust"
    }
   },
   "outputs": [],
   "source": [
    "# 服务切换 Python 运行自定义命令\n",
    "!which pip3\n",
    "!pip3 install requests"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "strategic-application",
   "metadata": {
    "vscode": {
     "languageId": "rust"
    }
   },
   "outputs": [],
   "source": [
    "import requests\n",
    "requests.get(\"https://www.baidu.com\").text"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "regulated-riverside",
   "metadata": {
    "vscode": {
     "languageId": "rust"
    }
   },
   "outputs": [],
   "source": [
    "// 服务切换 Rust 运行自定义命令\n",
    "println!(\"Hello Jupyter Book!\");\n",
    "println!(\"作者刚开始学习Rust,所以只会 println!\");"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "viral-print",
   "metadata": {
    "vscode": {
     "languageId": "shellscript"
    }
   },
   "outputs": [],
   "source": [
    "!curl ip.cip.cc"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "62f45ed7",
   "metadata": {},
   "source": [
    "## Jupyter LAB\n",
    "URL: http://localhost:8888/lab"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Rust",
   "language": "rust",
   "name": "rust"
  },
  "language_info": {
   "codemirror_mode": "rust",
   "file_extension": ".rs",
   "mimetype": "text/rust",
   "name": "Rust",
   "pygment_lexer": "rust",
   "version": ""
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
