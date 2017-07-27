# MyParcel.com Wiki

MyParcel.com docs for external documentation and resources.

## Todo
- [ ] Add contribution guidelines.

## Content
- [Installation](#installation)
- [Commands](#commands)
- [Resources](#resources)

### Installation
The project uses Docker to run a local development environment. To install Docker, follow the steps below for your preferred OS.

#### Mac
Install Docker for Mac from [https://docs.docker.com/docker-for-mac/install/](https://docs.docker.com/docker-for-mac/install/).

#### Windows
Install Docker for Windows from [https://docs.docker.com/docker-for-windows/install/](https://docs.docker.com/docker-for-windows/install/).

#### Linux
Install Docker by running the following command:
```bash
curl -sSL https://get.docker.com/ | sh
```

Then install Docker Compose by following the instructions [here](https://github.com/docker/compose/releases).

Finally assign yourself to the Docker group:
```bash
sudo usermod -aG docker $(whoami)
```

### Setup
To setup the project, run:
```bash
./mp.sh setup
```

### Commands
To start the server, run:
```bash
./mp.sh up
```
The server will watch file changes and reload automatically.

To stop the server, run:
```bash
./mp.sh down
```

To generate the static files, run (not needed when running the server):
```bash
./mp.sh generate
```

### Resources
Most resources for working with this setup can be found in the theme documentation.
- [Hugo](https://gohugo.io)
- [Hugo DocDock Theme](https://themes.gohugo.io/theme/docdock)

### Contributing
Coming Soon.

### Licence
All software by MyParcel.com is licenced under the [MyParcel.com general terms and conditions](https://www.myparcel.com/terms). 