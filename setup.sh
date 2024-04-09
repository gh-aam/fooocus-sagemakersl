#!/bin/bash

git clone https://github.com/lllyasviel/Fooocus.git
cd Fooocus

conda env create -f environment.yaml
eval "$(conda shell.bash hook)"
conda activate fooocus
pip install -r requirements_versions.txt
pip install pyngrok
conda install -y glib
conda deactivate

echo "{ \"path_checkpoints\": \"$(pwd)/models/checkpoints_data\" }" > config.txt
mv models/checkpoints models/checkpoints_data
ln -s models/checkpoints_data models/checkpoints
