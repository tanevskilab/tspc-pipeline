
process PRINTGPU {
  container "/home/hd/hd_hd/hd_dy329/singularity_images/cp-sam.sif"

  output:
  path "*.txt"

  script:
  """
  python -c "import torch; print(torch.cuda.is_available())" > gpu_check.txt
  """
}
// python -c "import torch; print(torch.cuda.is_available())"
workflow { 
  PRINTGPU()
}

