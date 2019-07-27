 ![SINDAN Project](https://raw.githubusercontent.com/mi2428/sindan-docker/screenshot/logo.png)

# sindan-docker

[![Build Status](https://travis-ci.com/mi2428/sindan-docker.svg?token=4rNKUsBRFsZs9zARiDBB&branch=master)](https://travis-ci.com/mi2428/sindan-docker) [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE) [![Issues](https://img.shields.io/github/issues/mi2428/sindan-docker)](https://github.com/mi2428/sindan-docker/issues)
[![last commit](https://img.shields.io/github/last-commit/mi2428/sindan-docker)](https://github.com/mi2428/sindan-docker/commits) [![Releases](https://img.shields.io/github/release/mi2428/sindan-docker)](https://github.com/mi2428/sindan-docker/releases)  [![relase date](https://img.shields.io/github/release-date/mi2428/sindan-docker)](https://github.com/mi2428/sindan-docker/releases)

Yet another dockerization of server-side [@SINDAN](https://github.com/SINDAN) suite
- **[sindan/sindan_docker](https://github.com/SINDAN/sindan_docker)** Official repository maintained by [@shored](https://github.com/shored)

## About SINDAN Project
Please visit website [sindan-net.com](https://www.sindan-net.com) for more details. (Japanese edition only)

> In order to detect network failure, SINDAN project evaluates the network status based on user-side observations, and aims to establish a method that enables network operators to troubleshoot quickly.

## Getting Started
These instructions will get you a copy of this project up and running on your environment for production purpose.
If you want to use this for development or testing purposes, it is necessary to edit some configurations appropriately.

### Prerequisites
**Docker with BuildKit support is needed.**
GNU/Make is not necessary, but it can reduce the number of commands you type.

- docker-engine: 18.06.0 and higher
- docker-compose: 1.22.0 and higher

### Build docker image and initialize DB
Set the password of MySQL database.
This file will not be tracked by Git.
```bash
$ echo PASSWORD_OF_YOUR_ENV | sha256sum | cut -d ' ' -f 1 > .secrets/db_password.txt
```
Register user account of SINDAN Web.
An account whose name is `sindan` and password is `changeme` is registered by default.
This file will not be tracked by Git.
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
Build dockerfile and initialize database.
This might take a while.
```bash
$ cp .secrets/rails_secret_key_base.txt.example .secrets/rails_secret_key_base.txt
$ make init
```

### Deploy
Deploy containers built previous steps.
```
$ make run log
```
Open your favorite browser and go [http://localhost:3000](http://localhost:3000) to see SINDAN Web.

![Safari screenshot](https://raw.githubusercontent.com/mi2428/sindan-docker/screenshot/safari.png)

### Stop and remove
```
$ make stop     # stop all containers
$ make clean    # remove all containers (data will not be lost)
$ make destroy  # remove all containers, volumes, images
```

## Contributing
Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning
We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/mi2428/sindan-docker/tags).

## Authors
- **Taichi MIYA** - *Initial work* - [@mi2428](https://github.com/mi2428)

See also the list of [contributors](https://github.com/mi2428/sindan-docker/graphs/contributors) who participated in this project.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
