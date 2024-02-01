#!/bin/sh
set -e

if command -v icdiff; then exit; fi

UPUP_viasudo icdiff
