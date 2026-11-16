
# Haplotype reconstruction for a real 3x3 half-diallel potato population

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
genofile = "TableS2_dose.csv"
pedfile = "TableS3_ped.csv"
```

## Run `polyorigin`

```julia
outstem = "potato4x_F1_out"
polyorigin(genofile,pedfile;
    isphysmap=true,
    recomrate=1.25,    
    chrsubset = 1:2, 
    isplot = true, 
    nplot_subpop = 1,  
    isparallel=true,
    outstem
)
```
The keyargs `isphysmap` and `recomrate` transform the input physical map (positions
in base pairs) into genetic map with specified constant recombination rate. `isparallel`
specifies if computations are parallel among chromosomes, and `outstem`
specifies the stem of output files.

If `isplot` is true, plot pedigree, map comparison, and founder-origin genotype probabilities. 
`nplot_subpop` specifies plotting for up to 1 offspring in each subpopulation. 

## Visualize conditional probability

```julia
joinedancestry = PolyOrigin.readjoinedancestry(outstem*"_joinedancestry.csv.gz")
```

Visualize haplotype probabilities of single offspring

```julia
plotcondprob(joinedancestry,offspring=1)
```

## Evaluate estimated map

Compare estimated map with input physical map

```julia
plotmapcomp(joinedancestry.markermap,
    joinedancestry.markermap,
    isphysmap = [true, false],
    xlabel = "Physical poistion (Mbp)",
    ylabel = "Estimated position (cM)",
)
```

where r is Kendall rank correlation for each chromosome.
