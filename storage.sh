#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate fooocus

rm -rf ~/.cache/*
rm -rf ~/fooocus-sagemakersl/Fooocus/outputs/*

df -h | grep -E 'Avail|home'
du -h --max-depth=1 ~

conda deactivate
