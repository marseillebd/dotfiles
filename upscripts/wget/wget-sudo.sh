#!/bin/sh
set -e

if command -v wget; then exit; fi

UPUP_viasudo wget
