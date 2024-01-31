#!/bin/sh
set -e

if command -v tree; then exit; fi

UPUP_viasudo tree
