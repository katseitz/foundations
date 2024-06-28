import os
import glob
import json
import shutil
import sys

if(len(sys.argv) > 1):
    participant = sys.argv[1]
else:
    participant = False 

##Deal with that we're in an infinite loop
if(participant):
    compressed_files = ["/projects/b1108/studies/foundations2/data/raw/neuroimaging/dicoms/compressed/ses-1/"+ participant +".zip"]
else:
    compressed_path = "/projects/b1108/studies/foundations2/data/raw/neuroimaging/dicoms/compressed/ses-1/"
    compressed_files = glob.glob(compressed_path + "*" )
uncompressed_path = "/projects/b1108/studies/foundations2/data/raw/neuroimaging/dicoms/uncompressed/ses-1/"
uncompressed_files = glob.glob(uncompressed_path + "*" )
problem_subs = []
#print(uncompressed_files)

for compressed in compressed_files:
    if(not(compressed == "/projects/b1108/studies/foundations2/data/raw/neuroimaging/dicoms/compressed/ses-1/complete")):
        
        print(compressed)
        #grabs subject id from compressed file name
        subject = compressed.split("/")[-1][0:6].lower()
        if(not(uncompressed_path + subject in uncompressed_files) and not(subject in problem_subs)):
            #print(uncompressed_path + subject)
            print(subject)
        #unzip/untar into participant dir
            shutil.unpack_archive(compressed, uncompressed_path + subject)


            #TO-DO Figure out who/what scans are missing FMAPS and hard code special cases
            #t1017 t1040 t1023 t1071 t1081 t1083 t1089 t1122 t1135 t1134 <-- intial hunch 

    

