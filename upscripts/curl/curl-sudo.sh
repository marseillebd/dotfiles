#!/bin/sh
set -e

if command -v curl; then exit; fi

UPUP_viasudo curl
