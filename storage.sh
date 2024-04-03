#!/bin/bash

rm -rf ~/.cache/*
rm -rf Fooocus/outputs/*

df -h | grep -E 'Avail|home'
du -h --max-depth=1 ~
