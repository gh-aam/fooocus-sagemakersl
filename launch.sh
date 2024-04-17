#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate fooocus
python ngrok.py
