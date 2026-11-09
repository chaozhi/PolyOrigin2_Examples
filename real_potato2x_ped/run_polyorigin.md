---
title: Haplotype reconstruction for a real diploid potato pedigree
author: Chaozhi Zheng
---

# Run `polyorigin` in cmd

First change into a working directory when genofile and pedfile are. Then run the following command line: 

```
>polyorigin -g potato2x_geno.vcf.gz -p potato2x_ped.csv ^
    --isphysmap true --recomrate 1.7 --chrsubset "[1,2]" ^
    --outstem potato2x_out --nworker 6
```
where the caret(`^`) is a multi-line character for Windows CMD, and the backslash (`\`) should be used instead for Linux/macOS shells. 

By default, `polyorigin` analyzes all chromosomes (`chrsubset` is nothing).  Here parallel computation consists of 6 workers: by default, 3 phasing runs for each of two specified chromosomes. If `nworker` == 1, non-parallel computation. 

[Click to view the cmd file](run_polyorigin.cmd)

# Help

For help, run
```
>polyorigin --help
```
