using PolyOrigin
using Plots
cd(@__DIR__)
pwd()

# run polyorigin
dataid = "sim_4x"
truegenofile = dataid*"_truegeno.vcf.gz"
trueorigfile = dataid*"_trueorig.vcf.gz"
genofile = dataid*"_geno.vcf.gz"   
pedfile = dataid*"_ped.csv"
outstem = dataid*"_out"
phasedgeno, polyancestry, joinedancestry = polyorigin(genofile,pedfile;     
    refhapfile = truegenofile, 
    trueorigfile,        
    samplesize = 100,     
    isplot = true, 
    nplot_subpop = 1, 
    maxrun = 1, 
    outstem, 
)

trueorig = readtruegeno!(trueorigfile,joinedancestry)        
PolyOrigin.plotcondprob(joinedancestry;                 
    ismidparent = true, 
    individual = 4,        
    dpi = 100,
    trueorig,
)

acc = calaccuracy!(truegenofile,trueorigfile, joinedancestry)

# deleted output files
# cd(@__DIR__)
# rm.(filter(x->occursin(outstem,x), readdir()))

