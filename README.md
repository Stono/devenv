# Devenv
This is my entire development environment, inside a set of containers.

The purpose here is that I can easily lift and shift my entire environment between machines, and ensure consistency across every environment.

## Components
The following components are installed:

  - vim:       8.0
  - docker:    17.06.0
  - compose:   1.14.0
  - nodejs:    8.1.4
  - ruby:      ruby-2.4.0
  - gcloud:    163.0.0
  - kubectl:   1.7.1
  - terraform: 0.9.11

### VIM
Vim is a compiled latest version (8) from the vim repo.  It is then configured with a whole bunch of extensions (see the Dockerfile) to basically turn it into a terminal IDE.

### Node/Ruby
I'm using nvm and rvm for both.

### Docker in Docker
As 95% of what i do involves docker, I needed docker available in my development environment.  I didn't want to be mounting the docker socket from my host, I wanted something totally isolated.  As a result I use docker-in-docker which gives you an isolated instance of docker inside the development environment.

## Persistence
I make use of two volumes, `code` which is mounted to `/storage`, where you should do all your work and `docker` which is mounted to `/var/lib/docker` in dind, to persist your images.  For convenience there is also a bind mount of `./host:/host`, in case you need to get anything out of the environment.

## Use
Simply type `./start.sh`
