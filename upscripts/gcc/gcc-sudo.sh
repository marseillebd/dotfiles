#!/bin/sh
set -e

if command -v gcc; then exit; fi

UPUP_viasudo gcc
