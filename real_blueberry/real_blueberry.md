# Haplotype reconstruction for a real tetraploid blueberry pedigree

## Setup `PolyOrigin`

For parallel computation

```julia
using Distributed
nprocs() < 7 && addprocs(7-nprocs())
@info string("nworkers=", nworkers())
@everywhere using PolyOrigin
```
Set four worker processes on local machine. The processes consist of 1 main and 6 workers: 
3 repeated phasing runs for each of two chromosomes. 

The last line makes `PolyOrigin` available on all processes.  

For non-parallel computation

```julia
using PolyOrigin
```

## Input files

Set working directory to the directory of this file.

```julia
cd(@__DIR__)
```

Set input files
```julia
dataid = "blueberry"
genofile = dataid*"_geno.vcf.gz"
pedfile = dataid*"_ped.csv"
```

## Run `polyorigin`

```julia
polyorigin(genofile,pedfile;
    isphysmap = true,
    recomrate = 2.6,
    chrsubset = 1:2 # anaylze only the first two chromosomes
    isparallel = true,
    isplot = true, 
    nplot_subpop = 1,  
    outstem = dataid*"_out"
)
```
The keyargs `isphysmap` and `recomrate` transform the input physical map (positions
in base pairs) into genetic map with specified constant recombination rate. `isparallel`
specifies if computations are parallel among chromosomes, and `outstem`
specifies the stem of output files.

If `isplot` is true, plot pedigree, map comparison, and founder-origin genotype probabilities. 
`nplot_subpop` specifies plotting for up to 1 offspring in each subpopulation. 
