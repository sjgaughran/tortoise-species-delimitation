################################################################################
### Species Delimitation with PHRAPL ###########################################
### Rachel Gray ################################################################
################################################################################
# Calculating wAIC from each model AIC 

# all rda files from PHRAPL runs in same folder, incldue AIC values
totalData<-ConcatenateResults(rdaFilesPath=paste0("/nobackup/proj/ejpr/Analyses/Species_delim/PHRAPL/"),rdaFiles=NULL,addAICweights=TRUE,addTime.elapsed=FALSE)

# calculate wAIC
modelAverages<-CalculateModelAverages(totalData, parmStartCol=9)

# save results
write.table(totalData, file=paste0("totalData.txt"), sep="\t", row.names=FALSE, quote=FALSE)