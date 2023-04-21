################################################################################
### Species Delimitation with PHRAPL ###########################################
### Rachel Gray ################################################################
################################################################################
# Model4: Migration and coalenscence, recent symmetric gene flow between pop 1 and 2, no change in pop size

library(ape)
library("phrapl")

trees<-read.tree("allspecies_50genetrees.tre")
#plot(trees)
assignFile<-read.table("clade_assignments.txt", header = TRUE)
print("load")

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

modelRange=4 # change according to model want to test 
nTrees<-100000

result<-GridSearch(migrationArray=migrationArray,modelRange=modelRange,
    popAssignments=popAssignments,observedTrees=observedTrees,
    subsampleWeights.df=subsampleWeights.df,
    nTrees=nTrees,collapseStarts=collapseStarts,
    migrationStarts=migrationStarts,
    totalPopVector=totalPopVector,
    addedEventTime=0.1,
    addedEventTimeScalar=TRUE)



# change the result name to match the number of trees simulated 
save(list="result",file="Model4.rda")
