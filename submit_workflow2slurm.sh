#!/bin/sh
#SBATCH --job-name="tspc-workflow"
#SBATCH --partition=cpu-single
#SBATCH --ntasks=1
#SBATCH --time=08:00:00
#SBATCH --mem=4gb

module load devel/java_jdk/1.18
module load system/singularity/3.11.3

nextflow run main.nf \
    -c nextflow.config \
    -profile apptainer \
    -with-report tspc-workflow-report.html \
    -resume
