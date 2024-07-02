#!/usr/bin/bash

#SBATCH -A p31833 #TODO insert your own pnumber
#SBATCH -p normal
#SBATCH -t 16:00:00
#SBATCH --array=1-1%10 #165 #TODO change this
#SBATCH --job-name="fmriprep_TEAM_\${SLURM_ARRAY_TASK_ID}"
#SBATCH --output=fmriprep.%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=15G

module purge
module load singularity/latest
echo "modules loaded" 
echo "beginning preprocessing"

IFS=$'\n' read -d '' -r -a input_args < list_subs.txt

export SINGULARITYENV_TEMPLATEFLOW_HOME=/projects/b1108/templateflow

#WITHOUT FMAP
singularity run --cleanenv --containall -B /projects/b1108:/projects/b1108 \
-B /projects/b1108/studies/foundations/data/preprocessed/neuroimaging:/base \
-B /projects/b1108/studies/foundations/scripts/2_QC:/scripts \
-B /projects/b1108/templateflow:/projects/b1108/templateflow \
-B /projects/b1108/studies/foundations/data/raw/neuroimaging/bids:/data \
/projects/b1108/software/singularity_images/fmriprep-23.2.1.simg \
/data /base/fmriprep-23.2.1 participant --nthreads 4 --omp-nthreads 3 --mem_mb 30000 \
--participant-label ${input_args[$SLURM_ARRAY_TASK_ID]} --bids-filter-file /scripts/bids_filter_file_ses-1.json \
--fs-license-file /projects/b1108/software/freesurfer_license/license.txt \
--fs-subjects-dir /base/freesurfer_23_2 \
--output-spaces MNI152NLin6Asym \
-w /base/work --ignore fieldmaps --skip_bids_validation