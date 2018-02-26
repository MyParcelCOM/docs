+++
title = "Docker"
weight = 1
+++

We use [Docker](https://www.docker.com) to run our applications in software containers. To install Docker, follow the steps below for your preferred OS.

## Mac
Install Docker for Mac from [https://docs.docker.com/docker-for-mac/install](https://docs.docker.com/docker-for-mac/install).

## Windows
Install Docker for Windows from [https://docs.docker.com/docker-for-windows/install](https://docs.docker.com/docker-for-windows/install).

## Linux
Install Docker by running the following command:

```bash
curl -sSL https://get.docker.com/ | sh
```

Then install Docker Compose by following the instructions [here](https://github.com/docker/compose/releases).

Finally assign yourself to the Docker group:

```bash
sudo usermod -aG docker $(whoami)
```
