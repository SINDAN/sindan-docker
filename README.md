 ![SINDAN Project](https://raw.githubusercontent.com/SINDAN/sindan-docker/screenshot/logo.png)

# sindan-docker

[![](http://img.shields.io/github/license/SINDAN/sindan-docker)](LICENSE) [![](https://img.shields.io/github/issues/SINDAN/sindan-docker)](https://github.com/SINDAN/sindan-docker/issues) [![](https://img.shields.io/github/issues-pr/SINDAN/sindan-docker)](https://github.com/SINDAN/sindan-docker/pulls) [![](https://img.shields.io/github/last-commit/SINDAN/sindan-docker)](https://github.com/SINDAN/sindan-docker/commits) [![](https://img.shields.io/github/release/SINDAN/sindan-docker)](https://github.com/SINDAN/sindan-docker/releases)

Dockerization of server-side [@SINDAN](https://github.com/SINDAN) suite
- **[Branch: shored-master](https://github.com/SINDAN/sindan-docker/tree/shored-master)** is the previous generation maintained by [@shored](https://github.com/shored) (soon to be deprecated and removed)

<!--[![asciicast](https://asciinema.org/a/336510.svg)](https://asciinema.org/a/336510)-->

## About SINDAN Project

Please visit our website [sindan-net.com](https://www.sindan-net.com) for more details. (Japanese edition only)

> In order to find the cause of network failure, the reports from users play an important role; however, in general, it is hard for users to describe their problems accurately.
>
> SINDAN project propose a method that can measure and analyze the network status based on the user-side observation, and enables network operators to troubleshoot quickly. Our goal also involves to define and standardize the network state description method.

## Getting Started

These instructions will get you a copy of this project up and running on your environment for production purpose.
If you want to use this for development or testing purposes, some configurations need to be fixed appropriately.

### Prerequisites

To build images on your local environment, **Docker with BuildKit support is needed.**
GNU/Make is not necessary, but it can reduce the number of commands you type.

- docker-engine: 18.06.0 and higher
- docker-compose: 1.22.0 and higher

By default, SINDAN servers listen and wait for requests from external network at the following ports.
Open these ports in your firewall beforehand as needed.

- [sindan/fluentd](https://hub.docker.com/r/sindan/fluentd): 8080/tcp, 8888/tcp
- [sindan/visualization](https://hub.docker.com/r/sindan/visualization): 3000/tcp
- [sindan/grafana](https://hub.docker.com/r/sindan/grafana): 3001/tcp

### Clone repository

First of all, you have to shallow clone this repository recursively with:

```bash
$ git clone --recursive --depth 1 https://github.com/SINDAN/sindan-docker
```

If you ran simple cloning command without recursive option or downloaded as a zip archive via browser,
make sure that all submodules are fully updated.

```bash
$ git submodule update --init --recursive
```

### Setup secrets

Git will ignore all of password files in `.secrets` directory, so that the updates are local-only.
Set the password of MySQL database.
For mac users, use `shasum -a 256` instead of `sha256sum` below.

```bash
$ echo PASSWORD_OF_YOUR_ENV | sha256sum | cut -d ' ' -f 1 > .secrets/db_password.txt
```

Register user accounts of SINDAN Web.
User's password must be **8-72 characters long**.
Sample `accounts.yml` registers an account whose name is `sindan` and password is `changeme`.

```bash
$ cp .secrets/accounts.yml.example .secrets/accounts.yml
$ vim .secrets/accounts.yml
```

You can register multiple accounts in bulk.

```yml
accounts:
  - username: hoge
    email: hoge@example.jp
    password: changeme
  - username: fuga
    email: fuga@example.jp
    password: changeme
```

Finally, set the Grafana's username and password to `gf_user.txt` and `gf_password.txt` respectively.

```bash
$ cp .secrets/gf_user.txt.example .secrets/gf_user.txt
$ cp .secrets/gf_password.txt.example .secrets/gf_password.txt
$ vim -p .secrets/gf_user.txt .secrets/gf_password.txt
```

### Build/Get docker images and initialize DB

Build dockerfile and initialize database. This might take a while.

```bash
$ cp .secrets/rails_secret_key_base.txt.example .secrets/rails_secret_key_base.txt
$ make build init
```

Instead of building locally, you can download pre-built images from [DockerHub](https://hub.docker.com/u/sindan).
Note that in this case, you must not edit `rails_secret_key_base.txt` as you like.
Just follow the next:

```bash
$ cp .secrets/rails_secret_key_base.txt.example .secrets/rails_secret_key_base.txt
$ make pull init
```

### Deploy

Deploy containers built or pulled previous steps.

```
$ make run log
```

Open your favorite browser and go [http://localhost:3000](http://localhost:3000) to see SINDAN Web.

![Safari screenshot](https://raw.githubusercontent.com/SINDAN/sindan-docker/screenshot/safari.png)

You can also access [Grafana](https://grafana.com/) with [http://localhost:3001](http://localhost:3001).
The screenshot will be added later.

<!-- ![screenshot of SINDAN Grafana](https://raw.githubusercontent.com/SINDAN/sindan-docker/screenshot/grafana.png) -->

### Stop and remove

```
$ make stop     # Stop all containers
$ make clean    # Remove all containers (data will not be lost)
$ make destroy  # Remove all containers, volumes, images
```

## Maintenance

Thanks to Git and Docker, it is very easy to maintain SINDAN servers even after the production deployment.
If you want to perform the *rolling update* or *zero downtime deployment*, consider using Kubernetes - check [charts](https://github.com/SINDAN/charts) for details.

### Backup and restore database

You can backup MySQL database anytime you want, and of course you can restore that in a simple way.
In the case of restoring, it is recommended to stop all containers in advance.

```
$ make backup   # Dump the database to ./sindan_database_YYYY-MMDD-HHMMSS.sql.gz
$ make restore  # Restore the database from ./restore.sql.gz
```

For example, if you are trying to deploy servers to new environment and you want to inherit the database created in previous environment,
following may help you:

```
$ git clone --recursive --depth 1 https://github.com/SINDAN/sindan-docker
$ cd sindan-docker
$ # Put the backup and rename it to restore.sql.gz
$ make pull restore run log
```

### Update repository

Just type `make update` and your local repository will be up to date with the latest version.
For safety reasons, **do not forget to stop all containers before the update.**
That is, the command you should run is like the following.
It sequencially executes *backup database*, *stop containers*, *update repository* and *restart containers*:

```
$ make backup clean update pull run
```

## Versioning

We use [CalVer](https://calver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/SINDAN/sindan-docker/tags).

## Authors

- **Tomohiro ISHIHARA** - *Initial work & Patch contribution* - [@shored](https://github.com/shored)
- **Taichi MIYA** - *Overhaul & Refactoring* - [@mi2428](https://github.com/mi2428)

See also the list of [contributors](https://github.com/SINDAN/sindan-docker/graphs/contributors) who participated in this project.

## License

This project is licensed under the BSD 3-Clause "New" or "Revised" License - see the [LICENSE](LICENSE) file for details.
