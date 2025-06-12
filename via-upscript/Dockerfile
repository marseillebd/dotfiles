# Do sysadmin stuff
FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y sudo

# Installing tzdata is annoying, bn/c it expects human input.
# The following SO answer has the magic incantation.
# https://serverfault.com/a/1016972
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get install -y tzdata
RUN apt-get install -y shared-mime-info


# DEBUG
RUN apt-get install -y \
  tree \
  less \
  wget curl \
  vim nano \
  git \
  gcc

# Setup a userland user
RUN useradd \
  --create-home \
  --shell /bin/sh newuser
RUN echo >/etc/sudoers.d/newuser 'newuser ALL = NOPASSWD: ALL'

USER newuser
WORKDIR /home/newuser

# try out some scripts
COPY --chown=newuser:newuser upup.sh upup.sh
COPY --chown=newuser:newuser profiles/ profiles/
COPY --chown=newuser:newuser upscripts/ upscripts/
