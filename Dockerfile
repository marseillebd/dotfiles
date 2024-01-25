# Do sysadmin stuff
FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y sudo

RUN apt-get install -y \
  curl wget \
  tree

# Setup a userland user
RUN useradd \
  --create-home \
  --shell /bin/sh newuser
RUN echo >/etc/sudoers.d/newuser 'newuser ALL = NOPASSWD: ALL'

USER newuser
WORKDIR /home/newuser

# try out some scripts
COPY --chown=newuser:newuser dist/upscript-testing upscript
COPY --chown=newuser:newuser upscripts/ upscripts/
