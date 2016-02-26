# Linkchecker docker image

This is a docker image that comes preconfigured with a linkchecker tool. Documentation abot the tool can be found [here](https://wummel.github.io/linkchecker/man1/linkchecker.1.html#index)

The image is configured to work with the Docker plugin for Jenkins CI. That is when no commands are given when you create a container from the image, it starts an SSH server, which Jenkins can use to create and connect a slave.

## Example

I've included a script as an example on how to use the script, `run.sh`.
