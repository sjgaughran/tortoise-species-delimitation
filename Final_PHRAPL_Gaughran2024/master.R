library(phrapl)
library(ape)


# load in the input gene tree and population assignments 
trees<-read.tree("phased_bestTree_chaco.tre")
assignFile<-read.table("clade_assignments.txt", header = TRUE)

#############################
#####   Define arguments  ###

# Number of population and individuals per population that will be subsampled
### Simulations showed that 2 or 3 individuals per population are enough.
popAssignments<-list(c(2,2))    # 2 populations and 3 individuals per population

subsamplesPerGene<-100     # subsamples per gene 

#############################
####  Do subsampling  #######

observedTrees<-PrepSubsampling(
  assignmentsGlobal=assignFile,      # the population assignments table
  observedTrees=trees,           # the original trees
  popAssignments=popAssignments,        # the number of tips subsampled per population
  subsamplesPerGene=subsamplesPerGene,  # the number of replicate subsamples to take per locus
  outgroup=TRUE,                       # whether an outgroup is present in the dataset (TRUE or FALSE)
  outgroupPrune=TRUE)                  # whether an outgroup, if present, should be excluded from the subsampled trees


#############################
### Get subsample weights ###
subsampleWeights.df<-GetPermutationWeightsAcrossSubsamples(popAssignments=popAssignments,
                                                           observedTrees=observedTrees)

# save list of subsampled trees and subsampled weights 
#save(list=c("observedTrees","subsampleWeights.df"),file="weights_trees.rda")

collapseStarts<-c(0.001,0.05,0.10,0.25,0.5,0.75,1)   
migrationStarts<-c(0.005, 0.02, 0.08, 0.12, 0.25, 0.4,0.8)			 
n0multiplierStarts<-NULL
options(scipen=999)
nTrees<-100000								
totalPopVector=list(c(6,6))
migrationArray<-readRDS("assymetrical_migrationArray.rds")

# Model 3 in (gene flow, single species)

modelRange=2 # change according to model want to test 
setCollapseZero=1:2
result<-GridSearch(migrationArray=migrationArray,
	modelRange=modelRange,
    	popAssignments=popAssignments,
	observedTrees=observedTrees,
   	subsampleWeights.df=subsampleWeights.df,
  	nTrees=nTrees,
	collapseStarts=collapseStarts,
    	migrationStarts=migrationStarts,
   	totalPopVector=totalPopVector,
	print.ms.string=TRUE,
	print.results=TRUE,
	debug=TRUE,return.all=TRUE,
	setCollapseZero=setCollapseZero,
	subsamplesPerGene=100,
	print.matches=TRUE,
	addedEventTime=NULL,
	addedEventTimeScalar=TRUE)


# change the result name to match the number of trees simulated 
save(list="result",file="Model3.rda")

rm(result)
rm(modelRange)

# Model 1 Isolation only, coalescent event, no gene flow
setCollapseZero=NULL
modelRange=1 # change according to model want to test 

result<-GridSearch(migrationArray=migrationArray,
	modelRange=modelRange,
    	popAssignments=popAssignments,
	observedTrees=observedTrees,
   	subsampleWeights.df=subsampleWeights.df,
  	nTrees=nTrees,
	collapseStarts=collapseStarts,
    	migrationStarts=migrationStarts,
   	totalPopVector=totalPopVector,
	print.ms.string=TRUE,
	print.results=TRUE,
	debug=TRUE,return.all=TRUE,
	setCollapseZero=setCollapseZero,
	subsamplesPerGene=100,
	print.matches=TRUE,
	addedEventTime=NULL,
	addedEventTimeScalar=TRUE)


# change the result name to match the number of trees simulated 
save(list="result",file="Model1.rda")

rm(result)
rm(modelRange)

# Model 2 (no gene flow, two species)
modelRange=2 # change according to model want to test 

result<-GridSearch(migrationArray=migrationArray,
	modelRange=modelRange,
    	popAssignments=popAssignments,
	observedTrees=observedTrees,
   	subsampleWeights.df=subsampleWeights.df,
  	nTrees=nTrees,
	collapseStarts=collapseStarts,
    	migrationStarts=migrationStarts,
   	totalPopVector=totalPopVector,
	print.ms.string=TRUE,
	print.results=TRUE,
	debug=TRUE,return.all=TRUE,
	setCollapseZero=setCollapseZero,
	subsamplesPerGene=100,
	print.matches=TRUE,
	addedEventTime=NULL,
	addedEventTimeScalar=TRUE)


# change the result name to match the number of trees simulated 
save(list="result",file="Model2.rda")

rm(result)
rm(modelRange)


# Post Processing 
totalData<-ConcatenateResults(rdaFilesPath=paste0(getwd(),"/"),rdaFiles=NULL,addAICweights=TRUE,addTime.elapsed=FALSE)
write.table(totalData, file=paste0("totalData.txt"), sep="\t", row.names=FALSE, quote=FALSE)

modelAverages<-CalculateModelAverages(totalData, parmStartCol = 8, keep.na = TRUE) 
write.table(modelAverages, file=paste0("modelAverages.txt"), sep="\t", row.names=FALSE, quote=FALSE)

gdi<-CalculateGdi(modelAverages$t1_1.2,modelAverages$m1_1.2,  msPath = "/mnt/nfs/home/c1009519/miniconda3/envs/linux_env_phrapl/bin/ms ")
write.table(gdi, file=paste0("gdi.txt"), sep="\t", row.names=FALSE, quote=FALSE)
