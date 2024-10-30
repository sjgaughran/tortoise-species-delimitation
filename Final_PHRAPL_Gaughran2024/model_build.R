################################################################################
### Species Delimitation with PHRAPL ###########################################
################################################################################


#install.packages(c("ape", "partitions", "lattice", "polynom", "gmp", "rgenoud","parallel", "optimx", "igraph", "numDeriv", "nloptr", "Matrix", "rgl", "RColorBrewer", "binom", "diagram", "P2C2M"))
#install.packages("devtools")
#devtools::install_github("bomeara/phrapl")

library(phrapl)

#### Script 1: Model Construction 
##--------------------------------------
# Model 1: Isolation only, coalescent event, no gene flow, no change in pop size 
collapseList = list(c(1,1))
n0multiplierList = list(c(1,1))
growthList = list(c(0,0))
migrationList<-list(  
  t(array(c(  
    NA, 0,  
    0, NA),  
    dim=c(2,2)))) 
model1<-GenerateMigrationIndividualsOneAtATime(collapseList=collapseList,
                                               n0multiplierList=n0multiplierList,growthList=growthList,migrationList=migrationList)

pdf("Model1.pdf")      # use this function to save a pdf directly
PlotModel2D(model1, taxonNames=c("Pop1", "Pop2"))
dev.off()


# Model 2: Migration and coalenscence, symmetric gene flow between pop 1 and 2, no change in pop size
collapseList = list(c(1,1))
n0multiplierList = list(c(1,1))
growthList = list(c(0,0))
migrationList<-list(  
  t(array(c(  
    NA, 1,  
    1, NA),  
    dim=c(2,2)))) 
model2<-GenerateMigrationIndividualsOneAtATime(collapseList=collapseList,
                                               n0multiplierList=n0multiplierList,growthList=growthList,migrationList=migrationList)

pdf("Model2.pdf")      # use this function to save a pdf directly
PlotModel2D(model2, taxonNames=c("Pop1", "Pop2"))
dev.off()


#migrationArray<-GenerateMigrationIndividuals(popVector=popVector,maxK=maxK,  
#                                             maxMigrationK=maxMigrationK,maxN0K=maxN0K,maxGrowthK=maxGrowthK, forceTree = TRUE)

migrationArray<-c(model1, model2)

saveRDS(migrationArray, file="assymetrical_migrationArray.rds")