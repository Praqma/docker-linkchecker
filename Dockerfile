
# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM debian:stretch
LABEL authors="Mads Nielsen <man@praqma.net>, Claus Schneider <claus.schneider@praqma.net>"

# Install and configure a basic SSH server and jdk for Jenkins slave
RUN apt-get update &&\
    apt-get install -y apt-utils &&\
    apt-get install -y openssh-server &&\
    apt-get install -y git &&\
    apt-get install -y wget &&\
    apt-get install -y openjdk-8-jdk && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd 

# Set user jenkins to the image
RUN adduser --quiet jenkins &&\
    echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

# Install Python 2.7.14 - NOTE: the newest is not available for apt-get install
#    make distclean && \
#    apt-get autoremove -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev && \
RUN apt-get update && \
    apt-get install -y build-essential checkinstall && \
    apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev && \
    cd /usr/src/ && \
    wget -q https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz && \
    tar xzf Python-2.7.14.tgz && \
    cd Python-2.7.14/ && \
    ./configure && \
    make altinstall && \
    cd /usr/src && \
    which python2.7 && \
    python2.7 -V && \
    ln -sf /usr/local/bin/python2.7 /usr/local/bin/python && \
    python -V && \
    which python && \
    rm -rf Python-2.7.14/ && \
    rm -rf Python-2.7.14.tar && \
    rm -rf Python-2.7.14.tgz && \
    apt-get autoremove -y build-essential checkinstall && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* 

# Install PiP
RUN wget -q https://bootstrap.pypa.io/get-pip.py -O - | python && \
    pip -V && \
    which pip

# Install linkchecker from sources as it is more dynamic - currently from a sha1 on master, but should later be a tag
RUN pip install git+https://github.com/linkcheck/linkchecker.git@22449ab && \
    rm -rf /tmp/pip-*-build



CMD ["/usr/sbin/sshd", "-D"]
