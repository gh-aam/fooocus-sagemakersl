#!/bin/bash

if [ ! -d "Fooocus" ]; then
    git clone https://github.com/lllyasviel/Fooocus.git
    cd Fooocus
    echo "{ \"path_checkpoints\": \"$(pwd)/models/checkpoints_data\" }" > config.txt
    mv models/checkpoints models/checkpoints_data
    ln -s models/checkpoints_data models/checkpoints
else
    cd Fooocus && git pull
fi
cd ..

eval "$(conda shell.bash hook)"

if [ ! -d "/home/studio-lab-user/.conda/envs/fooocus" ]; then
    cd Fooocus
    conda env create -f environment.yaml
    conda activate fooocus
    pip install -r requirements_versions.txt
    pip install pyngrok
    conda install -y glib
    conda deactivate
fi

cd ..
conda activate fooocus
if [ $# -eq 0 ]; then
    python ngrok.py 
elif [ $1 = "reset" ]; then
    python ngrok.py --reset 
fi
