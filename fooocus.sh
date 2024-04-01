#!/bin/bash

read -p "Temporary installation (true/false)? " install_in_temp_dir

if [ ! -d "Fooocus" ]
then
    git clone https://github.com/lllyasviel/Fooocus.git
fi
cd Fooocus
git pull

if [ "$install_in_temp_dir" = true ]
then
    echo "Installation folder: /tmp/fooocus_env"
    if [ ! -L ~/.conda/envs/fooocus ]
    then
        echo "removing ~/.conda/envs/fooocus"
        rm -rf ~/.conda/envs/fooocus
        rmdir ~/.conda/envs/fooocus
        ln -s /tmp/fooocus_env ~/.conda/envs/fooocus
    fi
else
    echo "Installation folder: ~/.conda/envs/fooocus"
    if [ -L ~/.conda/envs/fooocus ]
    then
        rm ~/.conda/envs/fooocus
    fi
fi

eval "$(conda shell.bash hook)"

if [ ! -d ~/.conda/envs/fooocus ]
then 
    echo ".conda/envs/fooocus is not a directory or does not exist"
fi

if [ ! -d /tmp/fooocus_env ] 
then
    echo "/tmp/fooocus_env is currently not a directory"
fi

if [ "$install_in_temp_dir" = true ] && [ ! -d /tmp/fooocus_env ] || [ "$install_in_temp_dir" = false ] && [ ! -d ~/.conda/envs/fooocus ]
then
    echo "Installing"
    
    if [ "$install_in_temp_dir" = true ] && [ ! -d /tmp/fooocus_env ]
    then
        echo "Creating /tmp/fooocus_env"
        mkdir /tmp/fooocus_env
    fi
    
    conda env create -f environment.yaml
    conda activate fooocus
    pwd
    ls
    pip install -r requirements_versions.txt
    pip install torch torchvision --force-reinstall --index-url https://download.pytorch.org/whl/cu117
    pip install pyngrok
    rm -f /opt/conda/.condarc
    conda install -y conda-forge::glib
    rm -rf ~/.cache/pip
fi

current_folder=$(pwd)
model_folder=${current_folder}/models/checkpoints-real-folder
if [ ! -e config.txt ]
then
    json_data="{ \"path_checkpoints\": \"$model_folder\" }"
    echo "$json_data" > config.txt
    echo "JSON file created: config.txt"
else
    echo "Updating config.txt to use checkpoints-real-folder"
    jq --arg new_value "$model_folder" '.path_checkpoints = $new_value' config.txt > config_tmp.txt && mv config_tmp.txt config.txt
fi

if [ ! -L models/checkpoints ]
then
    mv models/checkpoints models/checkpoints-real-folder
    ln -s models/checkpoints-real-folder models/checkpoints
fi

conda activate fooocus
cd ..
if [ $# -eq 0 ]
then
    python ngrok.py 
elif [ $1 = "reset" ]
then
    python ngrok.py --reset 
fi
