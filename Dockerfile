FROM ubuntu:trusty

MAINTAINER Ali <ali@praqma.net>

WORKDIR /data

RUN apt-get update \
&& apt-get install -y apt-utils \
&& apt-cache showpkg linkchecker \
&& apt-get install -y linkchecker

ENTRYPOINT ["linkchecker"]

CMD ["--help"]
