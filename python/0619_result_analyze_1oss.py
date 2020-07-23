import numpy as np
import pandas as pd
import sys

foldername = sys.argv[1]
filename = sys.argv[2]

columns = ['nodename', 'filesize_per_thread max_pages max_flight', 'numjobs','stripecount','95per','99per','99.9per','99.99per','min_iops','max_iops','avg_iops','throughput', \
'pm1_nvme0_io','pm1_nvme1_io','pm1_nvme2_io','pm1_nvme3_io', \
'pm1_nvme0_write','pm1_nvme1_write','pm1_nvme2_write','pm1_nvme3_write']
#'pm2_nvme0_io','pm2_nvme1_io','pm2_nvme2_io','pm2_nvme3_io', \
#'pm2_nvme0_write','pm2_nvme1_write','pm2_nvme2_write','pm2_nvme3_write', \
#'pm3_nvme0_io','pm3_nvme1_io','pm3_nvme2_io','pm3_nvme3_io', \
#'pm3_nvme0_write','pm3_nvme1_write','pm3_nvme2_write','pm3_nvme3_write']
dat_s = [0,0,0,0,0,0,0.0,0.0, \
0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
#,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0] #data storage
linecount = 0 #linecount

data_df = pd.DataFrame(columns=columns)

f = open("/mnt/share/cykim/result/"+foldername+"/"+filename+".txt", 'r')
lines = f.readlines()
for line in lines:
    if (line.find(",") == -1):
        continue
    elif (line.split(",")[4] == "3"):
        if (line.find(",,,,") != -1):
            linecount += 0
        elif (line.find(",,,") != -1):
            if(len(line.split(",")) < 21):
                continue
            linecount += 1
            dat_s[0] += int(line.split(",")[5])
            dat_s[1] += int(line.split(",")[6])
            dat_s[2] += int(line.split(",")[7])
            dat_s[3] += int(line.split(",")[8])
            #dat_s[4] += int(line.split(",")[9])
            dat_s[7] += int(line.split(",")[10])   #throughput
            #dat_s[6] += float(line.split(",")[11])
            #dat_s[7] += float(line.split(",")[12])

            dat_s[8] += float(line.split(",")[13])
            dat_s[9] += float(line.split(",")[14])
            dat_s[10] += float(line.split(",")[15])
            dat_s[11] += float(line.split(",")[16])
            dat_s[12] += float(line.split(",")[17])
            dat_s[13] += float(line.split(",")[18])
            dat_s[14] += float(line.split(",")[19])
            dat_s[15] += float(line.split(",")[20])

        elif (line.find(",,") != -1):
            if(len(line.split(",")) < 21):
                continue
            linecount += 1
            dat_s[0] += int(line.split(",")[5])
            dat_s[1] += int(line.split(",")[6])
            dat_s[2] += int(line.split(",")[7])
            dat_s[3] += int(line.split(",")[8])
            #dat_s[4] += int(line.split(",")[9])
            #dat_s[5] += int(line.split(",")[10])
            dat_s[7] += float(line.split(",")[11])
            #dat_s[7] += float(line.split(",")[12])

            dat_s[8] += float(line.split(",")[13])
            dat_s[9] += float(line.split(",")[14])
            dat_s[10] += float(line.split(",")[15])
            dat_s[11] += float(line.split(",")[16])
            dat_s[12] += float(line.split(",")[17])
            dat_s[13] += float(line.split(",")[18])
            dat_s[14] += float(line.split(",")[19])
            dat_s[15] += float(line.split(",")[20])
        else:
            if(len(line.split(",")) < 21):
                continue
            linecount += 1
            dat_s[0] += int(line.split(",")[5])
            dat_s[1] += int(line.split(",")[6])
            dat_s[2] += int(line.split(",")[7])
            dat_s[3] += int(line.split(",")[8])
            dat_s[4] += int(line.split(",")[9])
            dat_s[5] += int(line.split(",")[10])
            dat_s[6] += float(line.split(",")[11])
            dat_s[7] += float(line.split(",")[12])

            dat_s[8] += float(line.split(",")[13])
            dat_s[9] += float(line.split(",")[14])
            dat_s[10] += float(line.split(",")[15])
            dat_s[11] += float(line.split(",")[16])
            dat_s[12] += float(line.split(",")[17])
            dat_s[13] += float(line.split(",")[18])
            dat_s[14] += float(line.split(",")[19])
            dat_s[15] += float(line.split(",")[20])
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
                                     round(dat_s[7]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[8]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[9]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[10]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[11]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[12]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[13]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[14]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[15]/linecount,2) if linecount != 0 else 0
                                     ]], columns=columns)
        data_df = data_df.append(temp_df)
        data_df = data_df.reset_index(drop=True)
        
        #initialize
        dat_s = [0,0,0,0,0,0,0.0,0.0, \
        0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        linecount = 0
    else:
        if (line.find(",,,,") != -1):
            linecount += 0
        elif (line.find(",,,") != -1):
            if(len(line.split(",")) < 21):
                continue
            linecount += 1
            dat_s[0] += int(line.split(",")[5])
            dat_s[1] += int(line.split(",")[6])
            dat_s[2] += int(line.split(",")[7])
            dat_s[3] += int(line.split(",")[8])
            #dat_s[4] += int(line.split(",")[9])
            dat_s[7] += int(line.split(",")[10])   #throughput
            #dat_s[6] += float(line.split(",")[11])
            #dat_s[7] += float(line.split(",")[12])

            dat_s[8] += float(line.split(",")[13])
            dat_s[9] += float(line.split(",")[14])
            dat_s[10] += float(line.split(",")[15])
            dat_s[11] += float(line.split(",")[16])
            dat_s[12] += float(line.split(",")[17])
            dat_s[13] += float(line.split(",")[18])
            dat_s[14] += float(line.split(",")[19])
            dat_s[15] += float(line.split(",")[20])

        elif (line.find(",,") != -1):
            if(len(line.split(",")) < 21):
		continue
            linecount += 1
            dat_s[0] += int(line.split(",")[5])
            dat_s[1] += int(line.split(",")[6])
            dat_s[2] += int(line.split(",")[7])
            dat_s[3] += int(line.split(",")[8])
            #dat_s[4] += int(line.split(",")[9])
            #dat_s[5] += int(line.split(",")[10])
            dat_s[7] += float(line.split(",")[11])
            #dat_s[7] += float(line.split(",")[12])

            dat_s[8] += float(line.split(",")[13])
            dat_s[9] += float(line.split(",")[14])
            dat_s[10] += float(line.split(",")[15])
            dat_s[11] += float(line.split(",")[16])
            dat_s[12] += float(line.split(",")[17])
            dat_s[13] += float(line.split(",")[18])
            dat_s[14] += float(line.split(",")[19])
            dat_s[15] += float(line.split(",")[20])
        else:
            if(len(line.split(",")) < 21):
		continue
            linecount += 1
            dat_s[0] += int(line.split(",")[5])
            dat_s[1] += int(line.split(",")[6])
            dat_s[2] += int(line.split(",")[7])
            dat_s[3] += int(line.split(",")[8])
            dat_s[4] += int(line.split(",")[9])
            dat_s[5] += int(line.split(",")[10])
            dat_s[6] += float(line.split(",")[11])
            dat_s[7] += float(line.split(",")[12])
 
            dat_s[8] += float(line.split(",")[13])
            dat_s[9] += float(line.split(",")[14])
            dat_s[10] += float(line.split(",")[15])
            dat_s[11] += float(line.split(",")[16])
            dat_s[12] += float(line.split(",")[17])
            dat_s[13] += float(line.split(",")[18])
            dat_s[14] += float(line.split(",")[19])
            dat_s[15] += float(line.split(",")[20])
f.close()

#----------------------------
#if using only a few osts
#data_df = data_df.drop(["pm1_nvme1_io","pm1_nvme2_io","pm1_nvme3_io","pm1_nvme1_write","pm1_nvme2_write","pm1_nvme3_write"],axis=1)
r = data_df.to_csv("/mnt/share/cykim/result/"+foldername+"/"+filename+".csv", mode='w')
