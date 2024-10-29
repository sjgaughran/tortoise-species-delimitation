          seed =  -1

       seqfile = /gpfs/gibbs/pi/cgab/bpp/chaco_set1_1kb_w100kb_phased.txt
      Imapfile = /gpfs/gibbs/pi/cgab/bpp/tortoise_map_noLG_phased_Chaco.txt
       outfile = tortoise_phased_out.txt
      mcmcfile = tortoise_phased_mcmc.txt

  speciesdelimitation = 0 * fixed species tree
 * speciesdelimitation = 1 0 2  * species delimitation rjMCMC algorithm0 and finetune(e)
* speciesdelimitation = 1 1 2 1   * species delimitation rjMCMC algorithm1 finetune (a m)
 *         speciestree = 0       * species tree NNI/SPR
        speciestree = 1  0.4 0.2 0.1   * speciestree pSlider ExpandRatio ShrinkRatio

   speciesmodelprior = 1  * 0: uniform LH; 1:uniform rooted trees; 2: uniformSLH; 3: uniformSRooted

  species&tree = 14  A  W  C  U  E  T  F  L  R  Z  S  V  D  X
                    6  6  6  6  6  6  4  6  6  6  6  6  6  2
                  (X,((S,(Z,(E,F))),((R,A),((C,U),(L,(T,((W,D),V)))))));

         phase =   0  0  0  0  0  0  0  0  0  0  0  0  0
                  
       usedata = 1  * 0: no data (prior); 1:seq like
         nloci = 830  * number of data sets in seqfile

     cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

* This run is for shallow divergence and small ancestral population. 

    thetaprior = 3 0.001 e   # invgamma(a, b) for theta; mean=0.0025, var=0.0025
      tauprior = 3 0.01    # invgamma(a, b) for root tau & Dirichlet(a) for other tau's; mean=0.005, var=0.005

*     heredity = 1 4 4
*    locusrate = 1 5

      finetune = 1: 10.0 0.0003 0.00002 0.00001 0.1 .01 .01  # finetune for GBtj, GBspr, theta, tau, mix, locusrate, seqerr

       threads = 8

         print = 1 0 0 0   * MCMC samples, locusrate, heredityscalars, Genetrees
        burnin = 200000
      sampfreq = 2
       nsample = 500000
 *      BayesFactorBeta = 0.1
