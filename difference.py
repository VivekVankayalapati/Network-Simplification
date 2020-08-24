import numpy as np
import math as ma
import sys
import os
#import pandas as pd

#data_old = pd.read_fwf(sys.argv[1], skiprows=30)
#data_new = pd.read_fwf(sys.argv[2], skiprows=30)

#Loads the original abundance files
data_old = np.loadtxt(sys.argv[1], skiprows=30) #Skip rows is dependent on the timestep. This is fort 50 steps for a range of dex 4 to 7

#Loads the copy that will be edited
data_new = np.loadtxt(sys.argv[2], skiprows=30)

#os.system("echo starting...")

#Extracts the abundance
ab_old = data_old[:,1]

#Extracts the new abundance
ab_new = data_new[:,1]

#Computes the absolute fractional difference element by element
diff = (data_new-data_old)/data_old

diff = np.absolute(diff)

#Computes the percent adjusted average
average = np.sum(diff)/len(diff)*100


#If the values exceeds threshold value, store chemical as essential

#Feel free to comment stuff except line 38
os.system("echo " + str(average))
if average > 0.0:
        os.system("essential")
        os.system("echo " + str(average))
        os.system("echo " + sys.argv[4] + " >> essential.txt")
        
        os.system("echo " +  sys.argv[4] + " " + str(average) + " " + sys.argv[2] + " >> values.txt")
#elif average > 0.0:
        #os.system("echo non-essential")
        #os.system('echo ' + str(average))
#else:
    #os.system("echo non-essential")
#os.system("echo molcule done")
