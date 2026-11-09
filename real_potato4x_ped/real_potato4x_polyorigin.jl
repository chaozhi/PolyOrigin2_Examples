
using Distributed
nprocs() < 7 && addprocs(7-nprocs())
@info string("nprocs=", nprocs())
@everywhere  using PolyOrigin

using PolyOrigin
cd(@__DIR__)
pwd()

dataid = "potato4x"
genofile = dataid*"_geno.vcf.gz"
pedfile = dataid*"_ped.csv"
outstem = dataid*"_out"
chrsubset = 1:2
@time phasedgeno, polyancestry, joinedancestry = polyorigin(genofile, pedfile;
    isphysmap = true,
    recomrate = 1.25,
    chrsubset = chrsubset,    
    isplot = true, 
    nplot_subpop = 1,  
    outstem = outstem,
)
outfiles = filter(x -> occursin(outstem, x), readdir())
println("outfiles=", outfiles)

# plot haploprob
plotcondprob(joinedancestry;                     
    individual = 1
)
animcondprob(joinedancestry,fps=0.5,outfile=string(outstem,"_condprob.gif"))

# comparing maps
PolyOrigin.plotmapcomp(joinedancestry.markermap,
    joinedancestry.markermap,
    isphysmap = [true, false],
    xlabel = "Physical poistion (Mbp)",
    ylabel = "Estimated position (cM)",
)
