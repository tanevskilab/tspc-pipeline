#!/bin/sh
#SBATCH --job-name="cellpose_test"
#SBATCH --partition=gpu-single
#SBATCH --ntasks-per-node=2
#SBATCH --gres=gpu:1,gpumem_per_gpu:80GB
#SBATCH --time=8:00:00
#SBATCH --mem=210gb
#SBATCH --mail-user=dy329@uni-heidelberg.de

module load devel/java_jdk/1.18
module load system/singularity/3.11.3

nextflow run /gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/cellpose.nf \
    -c /gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/nextflow.config \
    -profile apptainer \
