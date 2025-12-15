pythonScript = "${workflow.projectDir}/bin/max_projection.py"

process MAX_PROJECTION {
    container "/home/hd/hd_hd/hd_dy329/singularity_images/cp-sam.sif"

    input:
    tuple val(meta), path(image)
    tuple val(meta2), path(channelfile)

    output:
    //stdout()
    tuple val(meta), path("*.tif*"), emit: max_proj_img

    script:
    """
    python ${pythonScript} --input_path $image --channel_file $channelfile
    """
}