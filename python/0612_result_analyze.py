import numpy as np
import pandas as pd

foldername = "0616"
filename = "Result_1556_CN10"

columns = ['nodename', 'bsize', 'numjobs','stripecount','95per','99per','99.9per','99.99per','min_iops','max_iops','avg_iops','throughput']
dat_s = [0,0,0,0,0,0,0.0,0.0] #data storage
linecount = 0 #linecount

data_df = pd.DataFrame(columns=columns)

f = open("/mnt/share/cykim/result/"+foldername+"/"+filename+".txt", 'r')
lines = f.readlines()
for line in lines:
    if (line.find(",") == -1):
        continue
    elif (line.split(",")[4] == "5"):
        if (line.endswith(",\n")):
            linecount += 0
        else:
            linecount += 1
            dat_s[0] += int(line.split(",")[5])
            dat_s[1] += int(line.split(",")[6])
            dat_s[2] += int(line.split(",")[7])
            dat_s[3] += int(line.split(",")[8])
            dat_s[4] += int(line.split(",")[9])
            dat_s[5] += int(line.split(",")[10])
            dat_s[6] += float(line.split(",")[11])
            dat_s[7] += float(line.split(",")[12])
            
        #record data into pd
        temp_df = pd.DataFrame(data=[[line.split(",")[0],line.split(",")[1], \
                                     line.split(",")[2],line.split(",")[3], \
                                     round(dat_s[0]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[1]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[2]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[3]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[4]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[5]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[6]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[7]/linecount,2) if linecount != 0 else 0 \
                                     ]], columns=columns)
        data_df = data_df.append(temp_df)
        data_df = data_df.reset_index(drop=True)
        
        #initialize
        dat_s = [0,0,0,0,0,0,0.0,0.0]
        linecount = 0
    else:
        if (line.endswith(",\n")):
            linecount += 0
        else:
            linecount += 1
            dat_s[0] += int(line.split(",")[5])
            dat_s[1] += int(line.split(",")[6])
            dat_s[2] += int(line.split(",")[7])
            dat_s[3] += int(line.split(",")[8])
            dat_s[4] += int(line.split(",")[9])
            dat_s[5] += int(line.split(",")[10])
            dat_s[6] += float(line.split(",")[11])
            dat_s[7] += float(line.split(",")[12])
        
f.close()

#----------------------------
r = data_df.to_csv("/mnt/share/cykim/result/"+foldername+"/"+filename+".csv", mode='w')
