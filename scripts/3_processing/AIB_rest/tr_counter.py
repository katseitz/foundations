### This script conducts the post-processing steps after fmriprep for rest
###
### kat
### January 2024

# Python version: 3.8.4
import os
import json
import csv
import glob
import pandas as pd #1.0.5
import nibabel as nib #3.2.1
import numpy as np

#from get_qual_metrics import get_qual_metrics


def main():
    ses = "ses-1" #bids ses-1
    outdir = '/projects/b1108/studies/foundations/data/processed/neuroimaging/aib_networks_rest/'
    subject_files = glob.glob(outdir + '*/*/*fd-1_final.nii.gz')
    tr_counts = [["ID", "run", "cleaned_shape"]]

    for sub_file in subject_files:
        ID = sub_file.split("/")[-1][0:10]
        run = sub_file.split("/")[-1][27:33]
        rest_img = nib.load(sub_file)
        tr_counts.append([ID, run, rest_img.shape])
                    
    with open(outdir + 'final_data/foundations_rsfMRI_TRs.csv', 'w') as myfile:
        wr = csv.writer(myfile, quoting=csv.QUOTE_ALL)
        for row in tr_counts:
            wr.writerow(row)
                                    
main()