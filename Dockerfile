
# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM python:2.7.14-stretch
LABEL authors="Mads Nielsen <man@praqma.net>, Claus Schneider <claus.schneider@praqma.net>"

# Install and configure a basic SSH server and jdk for Jenkins slave
RUN apt-get update &&\
    apt-get install -y openssh-server &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Set user jenkins to the image
RUN adduser --quiet jenkins &&\
    echo "jenkins:jenkins" | chpasswd

# Standard SSH port for the Jenkins Node
EXPOSE 22

# Install Python 2.7.14 - NOTE: the newest is not available for apt-get install
RUN apt-get update && \
    apt-get install -y build-essential checkinstall && \
    apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/* 


# Install linkchecker from sources as it is more dynamic - currently from a sha1 on master, but should later be a tag
COPY linkchecker /home/jenkins/linkchecker
RUN pip install -e /home/jenkins/linkchecker

COPY linkchecker.env /home/jenkins/linkchecker
RUN cat /home/jenkins/linkchecker/linkchecker.env

CMD ["/usr/sbin/sshd", "-D"]
