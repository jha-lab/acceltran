# AccelTran: A Sparsity-Aware Monolithic 3D Accelerator for Transformer Architectures at Scale

![Python Version](https://img.shields.io/badge/python-v3.6%20%7C%20v3.7%20%7C%20v3.8-blue)
![Conda](https://img.shields.io/badge/conda%7Cconda--forge-v4.8.3-blue)
![PyTorch](https://img.shields.io/badge/pytorch-v1.8.1-e74a2b)

AccelTran is a tool to simulate a design space of accelerators on diverse *flexible* and *heterogeneous* transformer architectures supported by the FlexiBERT 2.0 framework at [jha-lab/txf_design-space](https://github.com/JHA-Lab/txf_design-space). 

The figure below shows the utilization of different modules in an AccelTran architecture for the BERT-Tiny transformer model.

![AccelTran GIF](https://github.com/JHA-Lab/acceltran/blob/main/simulator/figures/bert_tiny.gif)

## Table of Contents
- [Environment Setup](#environment-setup)
  - [Clone this repository and initialize sub-modules](#clone-this-repository-and-initialize-sub-modules)
  - [Setup python environment](#setup-python-environment)
- [Run synthesis](#run-synthesis)
- [Run pruning](#run-pruning)
- [Run simulator](#run-simulator)

## Environment setup

### Clone this repository and initialize sub-modules

```shell
git clone https://github.com/JHA-Lab/acceltran.git
cd ./acceltran/
git submodule init
git submodule update
```

### Setup python environment  

The python environment setup is based on conda. The script below creates a new environment named `txf_design-space`:
```shell
source env_setup.sh
```
For `pip` installation, we are creating a `requirements.txt` file. Stay tuned!

## Run synthesis

Synthesis scripts use [Synopsys Design Compiler](https://www.synopsys.com/implementation-and-signoff/rtl-synthesis-test/dc-ultra.html). All hardware modules are implemented in SystemVerilog in the directory [synthesis/top](https://github.com/JHA-Lab/acceltran/tree/main/synthesis/top). 

To get area and power consumption reports for each module, use the following command:
```shell
cd ./synthesis/
dc_shell -f 14nm_sg.tcl -x "set top_module <M>"
cd ..
```
Here, `<M>` is the module that is to be synthesized in: `mac_lane`, `ln_forward_<T>` (for layer normalization), `softmax_<T>`, etc. where `<T>` is the tile size among 8, 16, or 32.

All output resports are stores in [synthesis/reports](https://github.com/JHA-Lab/acceltran/tree/main/synthesis/reports). 

To run the synthesis for the DMA module, run the following command instead:
```shell
cd ./synthesis/
dc_shell -f dma.tcl 
```

## Run pruning

To get the sparsity in activations and weights in an input transformer model and its corresponding performance on the GLUE benchmark, use the dynamic pruning model: DP-BERT. 

To test the effect of different sparsity ratios on the model performance on the SST-2 benchmark, use the following script:
```shell
cd ./pruning/
python3 run_evaluation.py --task sst2 --max_pruning_threshold 0.1
cd ..
```
The script uses a weight-pruned [model](https://huggingface.co/echarlaix/bert-base-uncased-sst2-acc91.1-d37-hybrid), and so, the weights are not pruned futher. To prune the weights with a `pruning_threshold` as well, use the flag: `--prune_weights`.

## Run simulator

AccelTran supports a diverse range of accelerator hyperparameters. It also supports all \~10<sup>88</sup> models in the FlexiBERT 2.0 design space.

To specify the configuration of an accelerator's architecture, use a configuration file in [simulator/config](https://github.com/JHA-Lab/acceltran/tree/main/simulator/config) directory. Example configuration files are given accelerators optimized for BERT-Nano and BERT-Tiny. Accelerator hardware configuration files should conform with the design space specified in the [simulator/design_space/design_space.yaml](https://github.com/JHA-Lab/acceltran/blob/main/simulator/design_space/design_space.yaml) file.

To specify the transformer model parameters, use a model dictionary file in [simulator/model_dicts](https://github.com/JHA-Lab/acceltran/tree/main/simulator/model_dicts). Model dictionaries for BERT-Nano and BERT-Tiny have already been provided for convenience.

To run AccelTran on the BERT-Tiny model, while plotting utilization and metric curves every 1000 cycles, use the following command:
```shell
cd ./simulator/
python3 run_simulator.py --model_dict_path ./model_dicts/bert_tiny.json --config_path ./config/config_tiny.yaml --plot_steps 1000 --debug
cd ..
```

This will output the accelerator state for every cycle. For more information on the possible inputs to the simulation script, use:
```shell
cd ./simulator/
python3 run_simulator.py --help
cd ..
```
