#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate fooocus
python launch_with_ngrok.py
