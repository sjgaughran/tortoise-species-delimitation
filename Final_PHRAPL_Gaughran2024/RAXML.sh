#!/bin/bash
#SBATCH -c 8
#SBATCH -t 0-10
#SBATCH --job-name=raxml
#SBATCH --output=raxml_%A_%a.out
#SBATCH --error=raxml_%A_%a.err
#SBATCH -p interactive
#SBATCH --time=1-00:00:00
#SBATCH --mem=20G
#SBATCH --mail-type=ALL


for  p in *.phy; do
raxmlHPC -s $p -m GTRGAMMA -n $p.tree -N 20 -o Chacoa,Chacob
done

