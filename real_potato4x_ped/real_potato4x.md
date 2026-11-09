---
title: "Haplotype reconstruction for a real tetraploid potato pedigree"
author: "Chaozhi Zheng"
---


# Setup PolyOrigin

For parallel computation
~~~~{.julia}
using Distributed
nprocs() < 7 && addprocs(7-nprocs())
@info string("nworkers=", nworkers())
@everywhere using PolyOrigin
~~~~~~~~~~~~~


Set four worker processes on local machine. See the manual
of `addprocs` for launching worker processes via the specified cluster manager
or on remote machines via SSH. The processers consist of  1 main and 6 wokers: 
3 repated phasing runs for each of two chromsomes. 

The last line makes PolyOrigin avaiable on all processes.  

For non-parallel computation
~~~~{.julia}
using PolyOrigin
~~~~~~~~~~~~~




# Input files

Set working directory to the direcotry of this file.
~~~~{.julia}
cd(@__DIR__)
~~~~~~~~~~~~~




Set input files
~~~~{.julia}
dataid = "potato4x"
genofile = dataid*"_geno.vcf.gz"
pedfile = dataid*"_ped.csv"
~~~~~~~~~~~~~




# Run polyorigin

run polyorigin
~~~~{.julia}
chrsubset = 1:2 # anaylze only the first two chromosomes
outstem = dataid*"_out"
~~~~~~~~~~~~~


~~~~{.julia}
@time phasedgeno, polyancestry, joinedancestry = polyorigin(genofile,pedfile;
    isphysmap = true,
    recomrate = 1.25,
    chrsubset,
    isparallel = true,
    isplot = true, 
    nplot_subpop = 1,  
    outstem
)
~~~~~~~~~~~~~


The keyargs `isphysmap`  and `recomrate` transform the input physical map (positions
in base pairs) into genetic map with speficied constant recombation rate. `isparallel`
specifies if computations are parallel among chromosomes, and `outstem`
specifies the stem of output files.

If `isplot` is true, plot pedigree, map comparision, and founder-origin genotype probablities. 
`nplot_subpop` specifies plotting for up to 1 offpsring in each subpopulation. 

~~~~{.julia}
outfiles = filter(x->occursin(outstem,x), readdir())
~~~~~~~~~~~~~

~~~~
11-element Vector{String}:
 "potato4x_out.log"
 "potato4x_out_chrpairing.csv"
 "potato4x_out_condprob.gif"
 "potato4x_out_imputed.vcf.gz"
 "potato4x_out_joinedancestry.csv.gz"
 "potato4x_out_maprefined.vcf.gz"
 "potato4x_out_nrecom.csv"
 "potato4x_out_phased.vcf.gz"
 "potato4x_out_plots"
 "potato4x_out_plots.tar"
 "potato4x_out_polyancestry.csv.gz"
~~~~




[Click to view log file](potato4x_out.log)

