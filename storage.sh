#!/bin/bash

parent_dir=$(pwd)
rm -rf ~/.cache/*
rm -rf

df -h | grep -E 'Avail|home'
du -h --max-depth=1 ~
