process CELLPOSESAM {
    label 'process_gpu'
    //conda "cellpose-sam"
    //container "cellpose_image.sif"

    input:
    tuple val(meta), path(image)

    output:
    //stdout()
    tuple val(meta), path("*.tif*"), emit: mask

    script:
    """
    python -m cellpose --use_gpu \
        --image_path $image \
        --pretrained_model /gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/cpsam_20250915_7 \
        --save_tif \
        --verbose
    """
}
//python -m cellpose --image_path $image --save_tif -verbose
//python -c "print('Hello, World!')"