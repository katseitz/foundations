#!/usr/bin/bash

#SBATCH -A p31833
#SBATCH -p normal
#SBATCH -t 1:00:00
#SBATCH --mem=1G
#SBATCH -J found_bidsdir
SES=$1
echo $SES

for DIR in /projects/b1108/studies/foundations2/data/raw/neuroimaging/dicoms/uncompressed/ses-1/*; do
    #these participants came in two parts and get special treatment
    if [ $(basename $DIR) != "t1140" ] && [ $(basename $DIR) != "t1123" ] && [ $(basename $DIR) != "t1135" ] && [ $(basename $DIR) != "t1120" ]; then
        BASE_DIR=$(basename $DIR)
        #[ -d "$dirs" ] && [ -n "$(ls -A $dirs)" ]
        if [ ! -f "/projects/b1108/studies/foundations2/data/raw/neuroimaging/bids/sub-$BASE_DIR/ses-1/anat/sub-${BASE_DIR}_${SES}_run-1_T1w.json" ]; then
            sbatch /projects/b1108/studies/foundations2/scripts/1_dicom_to_bids/99_dicom_to_bids_caller.sh $BASE_DIR $BASE_DIR $SES
            echo $BASE_DIR
        fi 
    fi
done
