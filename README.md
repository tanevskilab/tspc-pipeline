# tspc-pipeline
Customizable nextflow-based workflow to process multiplex immunofluorescence data.

IMPORTANT: currently under active development. Please submit requests as issues for future functionality.

## Instructions to run the pipeline

1. Follow the instructions to download the singularity images for the segmentation tools in the `singularity_images` directory.
2. Add the path of the image dataset in the `main.nf` script and modify also the paths for the other files (needs to be done only once).
3. Submit a slurm job for the pipeline:

`$ sbatch submit_workflow2slurm.sh`
