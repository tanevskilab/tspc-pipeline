#!/bin/sh
#SBATCH --job-name="cellpose_test"
#SBATCH --partition=gpu-single
#SBATCH --ntasks-per-node=2
#SBATCH --gres=gpu:1,gpumem_per_gpu:8GB
#SBATCH --time=1:00:00
#SBATCH --mem=12gb
#SBATCH --mail-user=dy329@uni-heidelberg.de

module load devel/java_jdk/1.18
module load system/singularity/3.11.3
#export NXF_SINGULARITY_CACHEDIR=$HOME/singularity_images
#singularity exec --nv cp-sam.sif nvidia-smi > output.txt
source /home/hd/hd_hd/hd_dy329/.bashrc

singularity exec --nv cp-sam.sif python -c "import torch; print(torch.cuda.is_available())" > gpu_avail.txt

