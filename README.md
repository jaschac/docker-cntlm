# jaschac/cntlm
#### Table of Contents
1. [Overview](#overview)
2. [Image Description](#image-description)
    * [How does jaschac/cntlm differ from other cNTLM images](#how-does-jaschac/cntlm-differ-from-other-cntlm-images)
3. [Setup](#setup)
    * [Pulling from the Docker Hub](#pulling-from-the-docker-hub)
    * [Building the Image from the Source](#building-the-image-from-the-source)
4. [Usage](#usage)
    * [How to use it through Containers](#how-to-use-it-through-containers)
    * [Docker Compose](#docker-compose)

### Overview
A Docker image that deploys the cNTLM authentication proxy, building it from the source. Please, do refer to the [official cNTLM documentation](http://cntlm.sourceforge.net/) for more details.

### Image Description
The jaschac/cntlm image is meant to allow containers to access the Internet through a proxy. As such:

 - **No plain text credential is exposed**. Only the cNTLM container knows how to get through the proxy and the password is encrypted.
 - In case the details to pass through the proxy change, **only one container must be updated**.
 - All containers can access the Internet simply linking to that executed from jaschac/cntlm and referring to it as the proxy during queries.

#### How does jaschac/cntlm differ from other cNTLM images
The typical scenario that requires cNTLM to be deployed is that of a Company that has a proxy and requires all users to authenticate each request with their own credentials. In such a scenario, unless the credentials are indeed exposed, the operating system cannot access the Internet, that is, it cannot pull anything from the repositories. In other words, unless **APT** is given username and plain text password, it will **not be able to pull and install anything**. **Not even cNTLM**!

Most of the cNTLM images present in the Docker Hub do indeed install cNTLM through APT. This means  one of the following cases apply:

 - APT is given plain text credentials.
 - Building the image fails, since cNTLM can't be pulled and installed.

To cope with this, jaschac/cntlm:

 - Is built on top of [jaschac/debian-gcc](https://github.com/jaschac/docker-debian-gcc), which is the official Debian Jessie image with the addition of GNU's gcc and make. Nothing else.
 - Comes with the official cNTLM 0.92.3 source code, which is first copied into the image then built.

This means that through the jaschac/cntlm image, **cNTLM can be installed without need to access the Internet**.

### Setup
There are two ways to get and use the jaschac/cntlm image:

#### Pulling from the Docker Hub
The jaschac/cntlm image can be easily pulled from the Docker Hub:

```bash
$ sudo docker pull jaschac/cntlm
```

#### Building the Image from the Source
jaschac/cntlm's source code can be freely pulled from [GitHub](https://github.com/jaschac/docker-cntlm) and used to build an image.

```bash
$ git clone git@github.com:jaschac/docker-cntlm.git cntlm
```

 Once pulled, the image will have the following structure:
```bash
cntlm/
├── [ 268]  Dockerfile
├── [4.0K]  files
│   ├── [4.0K]  cntlm-0.92.3
│   │   ├── [2.9K]  acl.c
│   │   ├── [1.1K]  acl.h
│   │   ├── [3.1K]  auth.c
│   │   ├── [2.0K]  auth.h
│   │   ├── [4.0K]  config
│   │   │   ├── [ 253]  endian.c
│   │   │   ├── [ 205]  gethostname.c
│   │   │   ├── [ 100]  socklen_t.c
│   │   │   └── [ 100]  strdup.c
│   │   ├── [3.5K]  config.c
│   │   ├── [1.5K]  config.h
│   │   ├── [1.7K]  configure
│   │   ├── [ 902]  COPYRIGHT
│   │   ├── [4.0K]  debian
│   │   │   ├── [ 163]  changelog
│   │   │   ├── [  74]  cntlm.default
│   │   │   ├── [2.1K]  cntlm.init
│   │   │   ├── [   2]  compat
│   │   │   ├── [ 802]  control
│   │   │   ├── [1.2K]  copyright
│   │   │   ├── [  37]  dirs
│   │   │   ├── [   7]  docs
│   │   │   ├── [ 123]  lintian-override
│   │   │   ├── [ 624]  postinst
│   │   │   ├── [ 610]  postrm
│   │   │   ├── [ 278]  prerm
│   │   │   ├── [1.7K]  rules
│   │   │   └── [  55]  watch
│   │   ├── [ 11K]  direct.c
│   │   ├── [ 999]  direct.h
│   │   ├── [4.0K]  doc
│   │   │   ├── [ 26K]  cntlm.1
│   │   │   ├── [2.8K]  cntlm.conf
│   │   │   └── [2.8K]  valgrind.txt
│   │   ├── [ 27K]  forward.c
│   │   ├── [1.2K]  forward.h
│   │   ├── [1.7K]  globals.h
│   │   ├── [ 14K]  http.c
│   │   ├── [1.8K]  http.h
│   │   ├── [ 18K]  LICENSE
│   │   ├── [ 39K]  main.c
│   │   ├── [4.7K]  Makefile
│   │   ├── [1.6K]  Makefile.xlc
│   │   ├── [ 11K]  ntlm.c
│   │   ├── [1.3K]  ntlm.h
│   │   ├── [2.5K]  pages.c
│   │   ├── [1.0K]  pages.h
│   │   ├── [5.1K]  README
│   │   ├── [4.0K]  rpm
│   │   │   ├── [8.0K]  cntlm.init
│   │   │   ├── [4.1K]  cntlm.spec
│   │   │   ├── [1022]  cntlm.sysconfig
│   │   │   └── [1.0K]  rules
│   │   ├── [7.8K]  scanner.c
│   │   ├── [1.1K]  scanner.h
│   │   ├── [6.3K]  socket.c
│   │   ├── [1.3K]  socket.h
│   │   ├── [2.2K]  swap.h
│   │   ├── [ 18K]  utils.c
│   │   ├── [4.7K]  utils.h
│   │   ├── [   7]  VERSION
│   │   ├── [4.0K]  win
│   │   │   ├── [  46]  Cntlm Homepage.url
│   │   │   ├── [7.0K]  cntlm.ico
│   │   │   ├── [ 672]  README.txt
│   │   │   ├── [  23]  resources.rc
│   │   │   ├── [2.3K]  setup.iss.in
│   │   │   ├── [  70]  Software Updates.url
│   │   │   └── [  73]  Support Website.url
│   │   ├── [ 43K]  xcrypt.c
│   │   └── [4.0K]  xcrypt.h
│   └── [4.0K]  etc
│       └── [2.4K]  cntlm.conf
├── [ 31K]  LICENSE
├── [ 481]  metadata.json
├── [  15]  README
├── [ 11K]  README.md
└── [4.0K]  scripts
    └── [1.5K]  init_container.sh
```

The jascha/cntlm image then can be built with the following command:

```bash
$ sudo docker build -t jaschac/cntlm -f cntlm/Dockerfile cntlm/
Successfully built f730765d27c7
$ sudo docker images
REPOSITORY                TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
jaschac/cntlm             latest              f730765d27c7        22 seconds ago      226.7 MB
```

## Usage
The jaschac/cntlm is meant to be run as a container which all other containers that need to access the Internet will link to. Starting such a container is fair simple but does **require some parameters to be provided through environment variables**.

The following parameters are mandatory:
 - **CNTLM_DOMAIN**
 - **CNTLM_PROXY_URL**
 - **CNTLM_USERNAME**

At least one of the following parameters is mandatory. Please make sure you check which one is expected by your proxy. Providing all of them does not hurt.
 - **CNTLM_PASSLM**
 - **CNTLM_PASSNT**
 - **CNTLM_PASSNTLMv2**
 

Note that in this case we are not passing the plain text password of the user, but its hash, which can be generated with the following command:
```bash
$ sudo cntlm -H
```

The following parameters are optional. If not provided, they will be assigned default values:

 - **CNTLM_PROXY_PORT**: it defaults to 3128
 - **CNTLM_NOPROXY**: it default to localhost, 127.0.0.*, 10.*, 192.168.*

```bash
sudo docker run --name cntlm -e CNTLM_USERNAME=jascha -e CNTLM_DOMAIN=lostinmalloc -e CNTLM_PROXY_URL=proxy.lostinmalloc.com -e CNTLM_PROXY_PORT=3128 -e CNTLM_PASSNTLMv2=62229EA8B6C0EEC4D887AD048960CC01 -d jaschac/cntlm
```

Upon launch, the container executes a Bash script that does the following:

 1. Validates the args passed.
 2. Builds and installs cNTLM from the source.
 3. Injects into the cNTLM configuration file the data passed by the user.
 4. Starts cNTLM in foreground, exposing port 3128.

```bash
$ sudo docker ps
CONTAINER ID    	IMAGE           		COMMAND            		CREATED         	STATUS          	PORTS           	NAMES
db596aa1279d    	jaschac/cntlm:latest    "/bin/sh -c init_con   	6 minutes ago   	Up 6 minutes    	3128/tcp        	cntlm
```

#### How to use it through containers
The best way to test jaschac/cntlm is to fire up a brand new container and access the Internet through the proxy by linking it to jaschac/cntlm. Let's create an *ad hoc* image that incapsulates this information into APT:

```bash
debian-test/
├── Dockerfile
├── etc
│   └── apt
│       └── apt.conf
├── metadata.json
└── README.md
```
The **apt.conf** file looks like this:
```bash
Acquire::http::Proxy "http://cntlm:3128";
```
The **Dockerfile** is as simple as:
```bash
FROM debian:jessie
MAINTAINER Jascha Casadio <jascha@lostinmalloc.com>
ADD etc/apt/apt.conf /etc/apt/apt.conf
RUN apt-get update -qq
RUN apt-get install -y -qq python-pip
```
With this image, we can fire up a container:
```bash
$ sudo docker run --rm=true --link cntlm:cntlm -it debian-test /bin/bash
```
The very important thing about this is the link. Inside the container that we have just fired up we will not have an entry, in /etc/hosts, that allows us to refer to it through 'cntlm'.  Once inside the container, we can:

 - Access APT: 
```bash
	root@7479e4ba7c3f:/# apt-get update
	Ign http://ftp.es.debian.org jessie InRelease
	Get:1 http://ftp.es.debian.org jessie-updates InRelease [135 kB]
	...
	Fetched 20.0 MB in 4s (4639 kB/s)                   	 
	Reading package lists... Done
```
 - Access the Internet through other services, as long as we use the link to cntlm:

```bash
	$ sudo pip install django
	Downloading/unpacking django
	  Cannot fetch index base URL http://pypi.python.org/simple/
	  Could not find any downloads that satisfy the requirement django
	No distributions at all found for django

	$ sudo pip --proxy cntlm:3128 install django
	Downloading/unpacking django
	...
	Successfully installed django
	Cleaning up...
```

Of course, we can export the following environment variables to our images, so that cntm is available to the containers without worries:

 - ftp_proxy=cntlm:3128
 - http_proxy=cntlm:3128
 - https_proxy=cntlm:3128

#### Docker Compose
The jaschac/cntlm can be easily used as part of a multi-container application through Docker Compose. This is how it can be configured to serve access through the proxy to another container:

```bash
cntlm:
  image: jaschac/cntlm
  environment:
    - CNTLM_USERNAME=jascha
    - CNTLM_DOMAIN=lostinmalloc
    - CNTLM_PROXY_URL=proxy.lostinmalloc.com
    - CNTLM_PROXY_PORT=3128
    - CNTLM_PASSNTLMv2=62229EA8B6C0EEC4D887AD048960CC01
whatever:
  image: whatever
  links:
    - cntlm:cntlm
  ...
```
