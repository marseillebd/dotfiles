#!/bin/sh
set -e

if command -v lolcat; then exit; fi

UPUP_viasudo lolcat
