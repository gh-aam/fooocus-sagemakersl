#!/bin/bash

rm -rf ~/.cache/*
rm -rf ~/fooocus-sagemakersl/Fooocus/outputs/*

df -h | grep -E 'Avail|home'
du -h --max-depth=1 ~
