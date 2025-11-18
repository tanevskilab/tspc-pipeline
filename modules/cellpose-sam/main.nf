process CELLPOSESAM {
    //abel 'process_gpu'
    //conda "cellpose-sam"
    container "/home/hd/hd_hd/hd_dy329/singularity_images/cp-sam.sif"

    input:
    tuple val(meta), path(image)

    output:
    //stdout()
    tuple val(meta), path("*.tif*"), emit: mask

    script:
    """
    export HOME=\$PWD

    python -m cellpose \
        --use_gpu \
        --pretrained_model /gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/cpsam_20250915_7 \
        --image_path $image \
        --save_tif \
        --verbose
    """
}
//python -m cellpose --image_path $image --save_tif -verbose
//python -c "print('Hello, World!')"
// export CELLPOSE_HOME=/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline
// --pretrained_model /gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/cpsam_20250915_7 \
// --save_tif \
// --use_gpu