#!/bin/sh
set -e

## One of these asks for user input, and then everything grinds to a halt for some reason.
## Thus, when installing nushell, you need to install these via apt on debian/ubuntu.
## It seems to have something to do with tzdata, and so perhaps won't sho up outside of my docker test cases. If so:
## - [ ] configure timezone for my testing docker image
sudo apt-get -y install pkg-config libssl-dev

echo "$PATH"

cargo install nu
