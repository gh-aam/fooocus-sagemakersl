#!/bin/bash

cd Fooocus
git pull
cd ..

eval "$(conda shell.bash hook)"
conda activate fooocus
if [ $# -eq 0 ]; then
    python ngrok.py 
elif [ $1 = "reset" ]; then
    python ngrok.py --reset 
fi
