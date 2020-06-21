import numpy as np
import pandas as pd
import sys

foldername = sys.argv[1]
filename = sys.argv[2]

columns = ['nodename', 'bsize', 'numjobs','stripecount','95per','99per','99.9per','99.99per','min_iops','max_iops','avg_iops','throughput', \
'pm1_nvme0_io','pm1_nvme1_io','pm1_nvme2_io','pm1_nvme3_io', \
'pm1_nvme0_write','pm1_nvme1_write','pm1_nvme2_write','pm1_nvme3_write', \
'pm2_nvme0_io','pm2_nvme1_io','pm2_nvme2_io','pm2_nvme3_io', \
'pm2_nvme0_write','pm2_nvme1_write','pm2_nvme2_write','pm2_nvme3_write']
dat_s = [0,0,0,0,0,0,0.0,0.0, \
0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0, \
0.0,0.0,0.0,0.0] #data storage
linecount = 0 #linecount

data_df = pd.DataFrame(columns=columns)

f = open("/mnt/share/cykim/result/"+foldername+"/"+filename+".txt", 'r')
lines = f.readlines()
for line in lines:
    if (line.find(",") == -1):
        continue
    elif (line.split(",")[4] == "5"):
#        if (line.endswith(",\n")):
        if (line.find(",,") != -1):
            linecount += 0
        else:
            if(len(line.split(",")) < 29):
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
            dat_s[16] += float(line.split(",")[21])
            dat_s[17] += float(line.split(",")[22])
            dat_s[18] += float(line.split(",")[23])
            dat_s[19] += float(line.split(",")[24])

            dat_s[20] += float(line.split(",")[25])
            dat_s[21] += float(line.split(",")[26])
            dat_s[22] += float(line.split(",")[27])
            dat_s[23] += float(line.split(",")[28])
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
                                     round(dat_s[15]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[16]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[17]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[18]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[19]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[20]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[21]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[22]/linecount,2) if linecount != 0 else 0, \
                                     round(dat_s[23]/linecount,2) if linecount != 0 else 0
                                     ]], columns=columns)
        data_df = data_df.append(temp_df)
        data_df = data_df.reset_index(drop=True)
        
        #initialize
        dat_s = [0,0,0,0,0,0,0.0,0.0, \
        0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0, \
        0.0,0.0,0.0,0.0] #data storage
        linecount = 0
    else:
#        if (line.endswith(",\n")):
        if (line.find(",,") != -1):
            linecount += 0
        else:
            if(len(line.split(",")) < 29):
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
            dat_s[16] += float(line.split(",")[21])
            dat_s[17] += float(line.split(",")[22])
            dat_s[18] += float(line.split(",")[23])
            dat_s[19] += float(line.split(",")[24])

            dat_s[20] += float(line.split(",")[25])
            dat_s[21] += float(line.split(",")[26])
            dat_s[22] += float(line.split(",")[27])
            dat_s[23] += float(line.split(",")[28])
f.close()

#----------------------------
r = data_df.to_csv("/mnt/share/cykim/result/"+foldername+"/"+filename+".csv", mode='w')
