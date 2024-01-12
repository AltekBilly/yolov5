#!/bin/bash
# Program:
#       This program train yolov5 model.
# History:
# 2024/01/10	Billy	First release

# PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
# export PATH
# echo -e "Hello World!"
# exit 0

# set env
MINICONDA_PATH="/home/BillyHsueh/miniconda3"      # set path of Miniconda
source "${MINICONDA_PATH}/etc/profile.d/conda.sh" # active Miniconda
CONDA_ENV_NAME="ultralytics"                      # set env name
conda activate "${CONDA_ENV_NAME}"                # active env
conda env list                                    # show current env

# set root of yolov5
root="/home/BillyHsueh/repo/yolov5"

# script
weights=""
cfg="${root}/models/yolov5altek.yaml"
data="${root}/data/wood_pallet.yaml"
hyp="${root}/data/hyps/hyp.altek.yaml"
epochs=300
batch_size=64
img_size=640
cache="ram" # ram/disk
device="2"
workers=1
name="test"
exist_ok=true
patience=50

if [ "$exist_ok" = true ]; then
    exist_ok="--exist-ok"
else
    exist_ok=""
fi

python train.py \
        --weights    "${weights}" \
        --cfg        "${cfg}" \
        --data       "${data}" \
        --epochs     "${epochs}" \
        --batch-size "${batch_size}" \
        --img-size   "${img_size}" \
        --device     "${device}" \
        --workers    "${workers}" \
        --name       "${name}" \
                     "${exist_ok}" \
        --patience   "${patience}" \
        # --cache      "${cache}" \
# exit env
conda deactivate