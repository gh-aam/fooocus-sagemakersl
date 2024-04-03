#!/bin/bash

parent_dir=$(pwd)
rm -rf ~/.cache/*
rm -rf $parent_dir/Fooocus/outputs/*

df -h | grep -E 'Avail|home'
du -h --max-depth=1 ~
