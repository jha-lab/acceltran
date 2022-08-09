#!/bin/bash

# Script to run the simulator for a given config path


cluster=""
id=""
bs=""
pe=""
sp=""
df=""

name=""
shortname=""
experiment=""

YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
ENDC='\033[0m'

Help()
{
   # Display Help
   echo -e "${CYAN}Script to fine-tune a given model${ENDC}"
   echo
   echo -e "Syntax: source ${CYAN}./job_scripts/job_finetune.sh${ENDC} [${YELLOW}flags${ENDC}]"
   echo "Flags:"
   echo -e "${YELLOW}-i${ENDC} | ${YELLOW}--id${ENDC} [default = ${GREEN}\"\"${ENDC}] \t\t\t Selected id to email slurm updates"
   echo -e "${YELLOW}-b${ENDC} | ${YELLOW}--bs${ENDC} [default = ${GREEN}\"\"${ENDC}] \t\t Buffer size"
   echo -e "${YELLOW}-p${ENDC} | ${YELLOW}--pe${ENDC} [default = ${GREEN}\"\"${ENDC}] \t\t Number of PEs"
   echo -e "${YELLOW}-s${ENDC} | ${YELLOW}--sp${ENDC} [default = ${GREEN}\"\"${ENDC}] \t\t Sparsity"
   echo -e "${YELLOW}-d${ENDC} | ${YELLOW}--df${ENDC} [default = ${GREEN}\"\"${ENDC}] \t\t Dataflow"
   echo -e "${YELLOW}-h${ENDC} | ${YELLOW}--help${ENDC} \t\t\t\t\t Call this help message"
   echo
}

while [[ $# -gt 0 ]]
do
case "$1" in
    -i | --id)
        shift
        id=$1
        shift
        ;;
    -b | --bs)
        shift
        bs=$1
        shift
        ;;
    -p | --pe)
        shift
        pe=$1
        shift
        ;;
    -s | --sp)
        shift
        sp=$1
        shift
        ;;
    -d | --df)
        shift
        df=$1
        shift
        ;;
    -h| --help)
       Help
       return 1;
       ;;
    *)
       echo "Unrecognized flag $1"
       return 1;
       ;;
esac
done  

if [[ $sp != "" ]]
then
    name="sp${sp}"
    shortname="${sp}"
    experiment="sparsity"
elif [[ $df != "" ]]
then
    name="${df}"
    shortname="${df//_}"
    experiment="dataflow"
else
    name="bs${bs}_pe${pe}"
    shortname="${bs}_${pe}"
    experiment="exploration"
fi

job_file="./job_${name}.slurm"
mkdir -p "./job_scripts/${experiment}/"

cd "./job_scripts/${experiment}/"

# Create SLURM job script
echo "#!/bin/bash" >> $job_file
echo "#SBATCH --job-name=${shortname}                     # create a short name for your job" >> $job_file
echo "#SBATCH --nodes=1                                      # node count" >> $job_file
echo "#SBATCH --ntasks-per-node=1                            # total number of tasks across all nodes" >> $job_file
echo "#SBATCH --cpus-per-task=4                              # cpu-cores per task (>1 if multi-threaded tasks)" >> $job_file
echo "#SBATCH --mem=64G                                      # memory per cpu-core (4G is default)" >> $job_file
echo "#SBATCH --time=23:59:00                                # total run time limit (HH:MM:SS)" >> $job_file
echo "#SBATCH --mail-type=fail" >> $job_file
echo "#SBATCH --mail-user=${id}@princeton.edu" >> $job_file
echo "" >> $job_file

echo "module purge" >> $job_file
echo "module load anaconda3/2020.7" >> $job_file
echo "conda activate txf_design-space" >> $job_file
echo "" >> $job_file
echo "cd ../.." >> $job_file
echo "" >> $job_file

if [[ $sp != "" ]]
then
    echo "python run_simulator.py --model_dict_path ./model_dicts/bert_tiny.json --config_path ./config/config_tiny.yaml --constants_path ./constants/sparsity/constants_sp${sp}.yaml --plot_steps 1000 --logs_dir ./results/sparsity/bert_tiny_edge_sp${sp}/ --debug" >> $job_file
elif [[ $df != "" ]]
then
    echo "python run_simulator.py --model_dict_path ./model_dicts/bert_tiny.json --config_path ./config/dataflow/config_tiny_${df}.yaml --constants_path ./constants/constants.yaml --plot_steps 1000 --logs_dir ./results/dataflow/bert_tiny_edge_${df}/ --debug" >> $job_file
else
    echo "python run_simulator.py --model_dict_path ./model_dicts/bert_tiny.json --config_path ./config/exploration/config_tiny_bs${bs}_pe${pe}.yaml --constants_path ./constants/constants.yaml --plot_steps 1000 --logs_dir ./results/exploration/bert_tiny_edge_bs${bs}_pe${pe}/ --debug" >> $job_file
fi

sbatch $job_file

cd ../..
