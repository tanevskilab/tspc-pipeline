#!/bin/sh
#SBATCH --job-name="cellpose_test"
#SBATCH --partition=cpu-single
#SBATCH --ntasks-per-node=2
#SBATCH --time=1:00:00
#SBATCH --mem=210gb
#SBATCH --mail-user=dy329@uni-heidelberg.de

module load devel/java_jdk/1.18
module load system/singularity/3.11.3

nextflow run /home/hd/hd_hd/hd_dy329/Repositories/tspc-pipeline/cellpose.nf \
    -c /home/hd/hd_hd/hd_dy329/Repositories/tspc-pipeline/nextflow.config \
    -profile apptainer \
    -resume
