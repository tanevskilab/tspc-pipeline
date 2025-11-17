#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { MCQUANT } from './modules/nf-core/mcquant/main' 
include { CELLPOSESAM } from './modules/cellpose-sam/main'

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

ch4cellpose = Channel.fromPath("/gpfs/bwfor/work/ws/hd_dy329-tspc/tspc-pipeline/exemplar-001-cycle-06.ome.tiff")


//ch1.view()
workflow {
    cellpose_ch = CELLPOSESAM(ch1)
    cellpose_ch.view()
    MCQUANT(ch1, cellpose_ch, ch3)
}
