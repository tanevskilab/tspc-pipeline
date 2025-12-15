#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { BACKSUB } from './modules/nf-core/backsub/main'
include { MAX_PROJECTION } from './modules/max_projection/main'
include { CELLPOSESAM } from './modules/cellpose-sam/main'
include { MCQUANT } from './modules/nf-core/mcquant/main' 


def id = "test_id"

ch1 = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/work/2f/4daf1e57ab4aff450e1abb1fd12bbd/20251202_18_R2049_2018_Panel2_TRITC_backsub_max_projected.tif")
    .map{ f -> [[id: f.simpleName], f]}


ch2 = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/exemplar-001-cycle-06_seg.tiff")
    .map{ f ->
        return [[id: f.simpleName], f]}

ch3 = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/markers.csv")
    .map{ f ->
        return [[id: f.simpleName], f]}

ch_markers_names = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/markers_nsclc.csv")
    .map{ f ->
        return [[id: f.simpleName], f]}

ch4 = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/20251202_18_R2049_2018_Panel2_TRITC_backsub.ome.tiff")
    .map{ f ->
        return [[id: f.simpleName], f]}

ch5 = Channel
    .fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/channels_max_proj.txt")
    .map{ f ->
        return [[id: f.simpleName], f]}

ch4cellpose = Channel.fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/exemplar-001-cycle-06.ome.tiff")


//ch1.view()
workflow {
    //max_proj_ch = MAX_PROJECTION(ch4, ch5)
    //max_proj_ch.view()
    //backsub_ch = BACKSUB(ch1, ch3)
    //cellpose_ch = CELLPOSESAM(max_proj_ch)
    cellpose_ch = CELLPOSESAM(ch1)
    //cellpose_ch.view()
    MCQUANT(ch4, cellpose_ch, ch_markers_names)
}
