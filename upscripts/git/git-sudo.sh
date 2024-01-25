#!/bin/sh
set -e

if command -v git; then exit; fi

UPUP_viasudo git
