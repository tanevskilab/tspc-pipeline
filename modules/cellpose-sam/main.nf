process CELLPOSESAM {
    label 'gpu_job'
    container "/home/hd/hd_hd/hd_dy329/singularity_images/cp-sam.sif"

    input:
    tuple val(meta), path(image)

    output:
    //stdout()
    tuple val(meta), path("*.tif*"), emit: mask
    //path("gpu_avail.txt"), emit: gpu_check

    script:
    """
    export HOME=\$PWD
    python -c "import torch; print(torch.cuda.is_available())" 
    python -m cellpose \
        --use_gpu \
        --image_path $image \
        --all_channels \
        --save_tif \
        --flow_threshold 0 \
        --verbose
    """
}
//python -m cellpose --image_path $image --save_tif -verbose
//python -c "print('Hello, World!')"
// export CELLPOSE_HOME=/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline
// --pretrained_model /gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/cpsam_20250915_7 \
// --save_tif \
// --use_gpu
