import pandas as pd
import glob 
import csv


def tsv_reader(path):
    sub = path.split("/")[-4]
    ses = path.split("/")[-3]

    
    events = pd.read_csv(path, sep='\t')

    fd_vals = events['framewise_displacement']
    
    return [sub, ses, fd_vals]

def main():
    dirs = glob.glob("/projects/b1108/studies/foundations/data/preprocessed/neuroimaging/fmriprep-23.2.1/sub-f*/ses-1/func/*mid_run-02_desc-confounds_timeseries.tsv") 
    df = pd.DataFrame()
    for i, path in enumerate(dirs):
        sub, ses, fd_vals = tsv_reader(path)
        temp_df = pd.DataFrame([[str(sub), str(ses)] + list(fd_vals)], columns=['sub', 'ses'] + [f'fd_{j}' for j in range(len(fd_vals))])
        df = pd.concat([df, temp_df], ignore_index=True)
        df_filled = df.fillna(0)
        df_filled.to_csv("HARP-F_ses-1_mid-run-2_fd_timeseries.csv")

if __name__ == "__main__":
    main()