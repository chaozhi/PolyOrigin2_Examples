
using Distributed
nprocs() < 7 && addprocs(7-nprocs()) # 1 main + 6 wokers: 3 repating runs for each of two chromsomes. 
@info string("nprocs=", nprocs())
@everywhere  using PolyOrigin

using PolyOrigin
cd(@__DIR__)
pwd()

genofile = "TableS2_dose.csv"
pedfile = "TableS3_ped.csv"
chrsubset = 1:2
outstem = "potato4x_F1_out"
@time phasedgeno, polyancestry, joinedancestry = polyorigin(genofile, pedfile;
    isphysmap = true,
    recomrate = 1.25,
    chrsubset = chrsubset,
    outstem = outstem,
)
outfiles = filter(x -> occursin(outstem, x), readdir())
println("outfiles=", outfiles)


# joinedancestry = PolyOrigin.readjoinedancestry(outstem*"_joinedancestry.csv.gz")

# comparing maps
PolyOrigin.plotmapcomp(joinedancestry.markermap,
    joinedancestry.markermap,
    isphysmap = [true, false],
    xlabel = "Physical poistion (Mbp)",
    ylabel = "Estimated position (cM)",
)

# plot haploprob
plotcondprob(joinedancestry;                     
    individual = 1
)
