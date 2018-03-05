# Linkchecker docker image


This is a docker image that comes preconfigured with a linkchecker tool. Documentation abot the tool can be found [here](https://linkcheck.github.io/linkchecker/) and the source code can be found here [here](https://github.com/linkcheck/linkchecker)

The image is configured to work with the Docker plugin for Jenkins CI. That is when no commands are given when you create a container from the image, it starts an SSH server, which Jenkins can use to create and connect a slave.

## Source code
The repo contains a `linkchecker` as a submodule and it is copied into the docker image and hereafter installed. 

* `git clone <repo> --recursive`

## Updating linkchecker to a new version or revision

* `cd linkchecker`
* `git checkout <sha1|branch|tag>` that you desire
* `cd -`
* `git add linkchecker`
* .. build the image


## Build by hand

The image is being auto-tagged using this wrapper script
* `docker_build.sh`

## Test and echo revision of linkchcker in Docker image

* Non-interactive: `./test.sh <IMAGE ID>|<repo>:<tag>`
* Interactive: `test.sh`and you will be prompted for input (IMAGE ID is required)

## Example

I've included a script as an example on how to use the script, `run.sh` or `linkchecker_cmd.sh`

