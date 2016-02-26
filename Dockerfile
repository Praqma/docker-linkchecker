
# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:14.04
MAINTAINER Mads <man@praqma.net>

# Install and configure a basic SSH server
RUN apt-get update &&\
    apt-get install -y apt-utils &&\
    apt-cache showpkg linkchecker &&\
    apt-get install -y linkchecker &&\
    apt-get install -y openssh-server &&\
    apt-get install -y git &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd 

# Install JDK 7 (latest edition)
RUN apt-get update &&\
    apt-get install -y openjdk-7-jdk &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Set user jenkins to the image
RUN adduser --quiet jenkins &&\
    echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
