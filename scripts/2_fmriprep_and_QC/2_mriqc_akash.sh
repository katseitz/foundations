#!/usr/bin/bash

#SBATCH -A p32480
#SBATCH -p short
#SBATCH -t 04:00:00
#SBATCH --mem=20G
#SBATCH -J qc-found
#SBATCH	--mail-type=END,FAIL
#SBATCH	--mail-user=akash.rathi@northwestern.edu

SUB=$1

module purge
module load singularity/latest
echo "modules loaded"
cd /projects/b1108

singularity run --cleanenv -B /projects/b1108:/projects/b1108/ \
/projects/b1108/software/singularity_images/mriqc-23.0.1.simg \
-v /projects/b1108/studies/foundations/data/raw/neuroimaging/bids/ \
-v /projects/b1108/studies/foundations/data/preprocessed/neuroimaging/mriqc/$SUB/ \
-w /projects/b1108/studies/foundations/data/preprocessed/neuroimaging/work/ \
participant --participant-label ${1}

