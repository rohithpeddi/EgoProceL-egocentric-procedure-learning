#!/bin/bash
conda create -n egoprocel python=3.9 pip
conda activate egoprocel
pip install -r requirements.txt
pip install numpy==1.23.5
pip install torch==1.13.0+cu116 torchvision==0.14.0+cu116 torchaudio==0.13.0 -f https://download.pytorch.org/whl/torch_stable.html