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

# Model 3: Migration and coalenscence, ancient symmetric gene flow between pop 1 and 2, no change in pop size
collapseList = list(c(NA, NA),c(1, 1)) 
collapseList[1:2]
n0multiplierList = list(c(1, 1),c(1, 1))
growthList = list(c(0,0),c(0,0))
migrationList<-list(  
  t(array(c(  
    NA, 0,  
    0, NA),  
    dim=c(2,2))),
  t(array(c(  
    NA, 1,  
    1, NA),  
    dim=c(2,2)))) 

model3<-GenerateMigrationIndividualsOneAtATime(collapseList=collapseList,
                                               n0multiplierList=n0multiplierList,growthList=growthList,migrationList=migrationList)

# Model4: Migration and coalenscence, recent symmetric gene flow between pop 1 and 2, no change in pop size
collapseList = list(c(NA, NA),c(1, 1)) 
n0multiplierList = list(c(1, 1),c(1, 1))
growthList = list(c(0,0),c(0,0))
migrationList<-list(  
  t(array(c(  
    NA, 1,  
    1, NA),  
    dim=c(2,2))),
  t(array(c(  
    NA, 0,  
    0, NA),  
    dim=c(2,2)))) 
model4<-GenerateMigrationIndividualsOneAtATime(collapseList=collapseList,
                                               n0multiplierList=n0multiplierList,growthList=growthList,migrationList=migrationList)


## create model element
popAssignments<-list(c(2,2))
popVector<-popAssignments[[1]]  
maxK<-0  
maxMigrationK=0 
maxN0K=0  
maxGrowthK=0  
forceTree=TRUE  
forceSymmetricalMigration=TRUE  
migrationArray<-GenerateMigrationIndividuals(popVector=popVector,maxK=maxK,  
                                             maxMigrationK=maxMigrationK,maxN0K=maxN0K,maxGrowthK=maxGrowthK, forceTree = TRUE)

migrationArray<-c(migrationArray,list(model1, model2, model3, model4)) 

saveRDS(migrationArray, file="4modeltypes_migrationArray.rds")
