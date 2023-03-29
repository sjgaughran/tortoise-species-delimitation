          seed =  -1

       seqfile = /ysm-gpfs/special/cgab/bpp/tortoise_1kb_w1Mb_diploid_filtered_bpp.txt
      Imapfile = /ysm-gpfs/special/cgab/bpp/tortoise_map_noLG.txt
       outfile = tortoise_out1.txt
      mcmcfile = tortoise_mcmc1.txt

*  speciesdelimitation = 1 * fixed species tree
  speciesdelimitation = 1 0 2  * species delimitation rjMCMC algorithm0 and finetune(e)
 speciesdelimitation = 1 1 2 1   * species delimitation rjMCMC algorithm1 finetune (a m)
 *         speciestree = 0       * species tree NNI/SPR
        speciestree = 1  0.4 0.2 0.1   * speciestree pSlider ExpandRatio ShrinkRatio

   speciesmodelprior = 1  * 0: uniform LH; 1:uniform rooted trees; 2: uniformSLH; 3: uniformSRooted

  species&tree = 13  A  W  C  U  E  T  F  L  R  Z  S  V  D
                    3  3  3  3  3  3  2  3  3  3  3  3  3
                  ((S,(Z,(E,F))),((R,A),((C,U),(L,(T,((W,D),V))))));

         phase =   1  1  1  1  1  1  1  1  1  1  1  1  1
                  
       usedata = 1  * 0: no data (prior); 1:seq like
         nloci = 50  * number of data sets in seqfile

     cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

* This run is for shallow divergence and small ancestral population. 

    thetaprior = 3 0.001 e   # invgamma(a, b) for theta; mean=0.0025, var=0.0025
      tauprior = 3 0.001    # invgamma(a, b) for root tau & Dirichlet(a) for other tau's; mean=0.005, var=0.005

*     heredity = 1 4 4
*    locusrate = 1 5

      finetune = 1: 0.5 0.0001 0.0001 0.00005 0.1 .01 .01  # finetune for GBtj, GBspr, theta, tau, mix, locusrate, seqerr

 *       threads = 5

         print = 1 0 0 0   * MCMC samples, locusrate, heredityscalars, Genetrees
        burnin = 100000
      sampfreq = 2
       nsample = 300000
       BayesFactorBeta = 0.1
