include { BACKSUB } from './modules/nf-core/backsub/main'
include { MAX_PROJECTION } from './modules/max_projection/main'
include { CELLPOSESAM } from './modules/cellpose-sam/main'
include { MCQUANT } from './modules/nf-core/mcquant/main' 

/**
 * Build a channel for a single image with the desired mapping.
 * @param path - full path to the TIFF file
 * @return Channel emitting [ [id: <basename>], <file> ]
 */

def buildMappedChannel(String path) {
    return Channel
        .fromPath(path)
        .map { f -> [ [id: f.simpleName], f ] }
}

backsub_img_ch = buildMappedChannel("/gpfs/bwfor/work/ws/hd_dy329-tspc/20251202_18_R2049_2018_Panel2_TRITC_backsub.ome.tiff")
markers_nsclc_ch = buildMappedChannel("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline-remove/tspc-pipeline/markers_nsclc.csv")
markers_backsub_ch = buildMappedChannel("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline-remove/tspc-pipeline/markers_nsclc_backsub.csv")

channels4max_proj_ch = buildMappedChannel("/home/hd/hd_hd/hd_dy329/Repositories/tspc-pipeline/channels2project.txt")

// Temporary fix, do cellpose segmentation outside the workflow
cellpose_ch = buildMappedChannel("/gpfs/bwfor/work/ws/hd_dy329-tspc/cellpose_results/20251202_18_R2049_2018_Panel2_TRITC_backsub_max_projected_cp_masks.tif")


workflow {
    backsub_img = BACKSUB(backsub_img_ch, markers_backsub_ch)
    backsub_img[0].view()

    max_proj_ch = MAX_PROJECTION(backsub_img[0], channels4max_proj_ch)

    //cellpose_ch = CELLPOSESAM(max_proj_ch)
    mc_quant_ch = MCQUANT(backsub_img[0], cellpose_ch, markers_nsclc_ch)
}
