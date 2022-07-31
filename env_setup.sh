#!/bin/sh

# Script to install required packages in conda from the FlexiBERT repo
# Author : Shikhar Tuli

if { conda env list | grep ".*txf_design-space*"; } >/dev/null 2>&1
then
	conda activate txf_design-space
else
	cd txf_design-space

	# module load anaconda3/2020.11
	conda create --name txf_design-space pytorch torchvision torchaudio cudatoolkit=11.1 --channel pytorch --channel nvidia

	conda activate txf_design-space

	# Already added in current repository
	# git clone https://github.com/huggingface/transformers.git
	cd transformers
	pip install -e .
	pip install torch-dct
	cd ..

	# Install datasets
	git clone https://github.com/huggingface/datasets.git
	cd datasets/
	pip install -e .
	cd ..

	# Add other packages and enabling extentions
	conda install -c conda-forge tqdm ipywidgets matplotlib scikit-optimize
	jupyter nbextension enable --py widgetsnbextension
	conda install -c anaconda scipy cython
	conda install pyyaml
	conda install pandas
	conda install -c plotly plotly

	# Conda prefers pip packages in the end
	pip install grakel
	pip install datasets
	pip install networkx
	pip install tabulate
	pip install optuna
fi
