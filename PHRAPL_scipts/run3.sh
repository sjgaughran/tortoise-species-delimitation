#!/bin/bash
#SBATCH -c 8
#SBATCH -t 0-10
#SBATCH --job-name=PHRAPL_test
#SBATCH --output=PHRAPL_Model3_%A_%a.out
#SBATCH --error=PHRAP_Model3_%A_%a.err
#SBATCH -p interactive
#SBATCH --time=1-00:00:00
#SBATCH --mem=8G
#SBATCH --mail-type=ALL

module load R 
Rscript Model_3.R
