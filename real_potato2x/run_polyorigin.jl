using Distributed
nprocs() < 7 && addprocs(7-nprocs())
@info string("nprocs=", nprocs())
@everywhere  using PolyOrigin

using PolyOrigin
cd(@__DIR__)
pwd()

# run polyorigin
dataid = "potato2x"
genofile = dataid*"_geno.vcf.gz"   
pedfile = dataid*"_ped.csv"
outstem = dataid*"_out"
phasedgeno, polyancestry, joinedancestry = polyorigin(genofile,pedfile;     
    isphysmap = true, 
    recomrate = 1.7,  
    chrsubset = 1:2,    
    isplot = true, 
    nplot_subpop = 1, 
    outstem, 
)
    
PolyOrigin.plotcondprob(joinedancestry;                 
    individual = 20,        
)

# deleted output files
# cd(@__DIR__)
# rm.(filter(x->occursin(outstem,x), readdir()))

