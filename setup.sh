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
