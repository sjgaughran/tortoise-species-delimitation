################################################################################
### Species Delimitation with PHRAPL ###########################################
### Rachel Gray ################################################################
################################################################################
# Model 2: Migration and coalenscence, symmetric gene flow between pop 1 and 2, no change in pop size

library(ape)
library("phrapl")

trees<-read.tree("allspecies_50genetrees.tre")
#plot(trees)
assignFile<-read.table("clade_assignments.txt", header = TRUE)

popAssignments<-list(c(2,2))
collapseStarts<-c(0.001,0.05,0.10,25,0.5,0.75,1)   
migrationStarts<-c(0.005, 0.02, 0.08, 0.12, 0.25, 0.4,0.8)		 
n0multiplierStarts<-NULL								
setCollapseZero<-NULL		
assignmentsGlobal<-assignFile  
observedTrees<-trees  
subsamplesPerGene<-20
outgroup=TRUE  
outgroupPrune=TRUE  

observedTrees<-PrepSubsampling(assignmentsGlobal=assignmentsGlobal,observedTrees=observedTrees,
                               popAssignments=popAssignments,subsamplesPerGene=subsamplesPerGene,outgroup=outgroup,
                               outgroupPrune=outgroupPrune)

subsampleWeights.df<-GetPermutationWeightsAcrossSubsamples(popAssignments=popAssignments,
                                                           observedTrees=observedTrees)



migrationArray<-readRDS("4modeltypes_migrationArray.rds")

modelRange=2 # change according to model want to test 
nTrees<-100000

result<-GridSearch(migrationArray=migrationArray,modelRange=modelRange,
    popAssignments=popAssignments,observedTrees=observedTrees,
    subsampleWeights.df=subsampleWeights.df,
    nTrees=nTrees,collapseStarts=collapseStarts,
    migrationStarts=migrationStarts,
    totalPopVector=totalPopVector)


# change the result name to match the number of trees simulated 
save(list="result",file="Model2.rda")

#write.table(totalData, file=paste0("totalData.txt"), sep="\t", row.names=FALSE, quote=FALSE)
