include { BACKSUB } from './modules/nf-core/backsub/main'
include { MCQUANT } from './modules/nf-core/mcquant/main'

def id = "test_id"

ch1 = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/exemplar-001-cycle-06.ome.tiff")
    .map{ f -> [[id: f.simpleName], f]}


ch2 = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/exemplar-001-cycle-06_seg.tiff")
    .map{ f ->
        return [[id: f.simpleName], f]}

ch3 = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/markers.csv")
    .map{ f ->
        return [[id: f.simpleName], f]}

markers_backsub_ch = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline-remove/tspc-pipeline/markers_nsclc_backsub.csv")
    .map{ f ->
        return [[id: f.simpleName], f]}


backsub_img_ch = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/20251202_18_R2049_2018_Panel2_TRITC_backsub.ome.tiff")
    .map{ f ->
        return [[id: f.simpleName], f]}

ch1.view()
workflow {
    backsub_img = BACKSUB(backsub_img_ch, markers_backsub_ch)

    //MCQUANT(ch1, ch2, ch3)
}