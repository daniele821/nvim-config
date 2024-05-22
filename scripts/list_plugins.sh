#!/bin/env bash

echo -e "\x1b[31;1mWARNING: this script is one hell of an heuristic, do not rely on it\x1b[m\n" >/dev/stderr

rg / ./lua/plugins/ -I | grep -v require | grep -v -- -- | grep -v lazypath | while read line; do echo $line; done | sort | uniq
