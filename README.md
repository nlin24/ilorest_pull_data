## Summary
The goal for the [system_baseline_compliance.py](https://github.com/nlin24/ilorest_pull_data/blob/master/system_baseline_compliance.py) script is twofold: When it does not find JSON baseline files at the current working directory, it connects to the iLO CMU through [Python iLO REST library](https://github.com/HewlettPackard/python-ilorest-library), makes query to the system information, and then downloads the BIOS baseline and the firmware inventory to the local directory. The name of the baseline files shows the system model, the iLO serial number, and the time stamp when it's generated. On the other hand, if there is already JSON baselines present in the current working directory, the script pulls BIOS configs and firmware inventory from iLO, and then compares those data against the latest baseline, such that if there are multiple baselines, the script only compares to the one with the latest time stamp. 

The script has been tested on Windows, with Gen9 iLO4 (iLO4 FW 2.61 Jul 27 2018), and Gen10 iLO5 (iLO5 FW 1.37 Oct 25 2018), in production mode.
 
## Environment and Setup
This script has been tested on Python 3.7.3. Pythons can either be downloaded and installed from [https://www.python.org/downloads/](https://www.python.org/downloads/). Linux users may need to build from source.
Dependencies are listed in _requirements.txt_. Use Pip to install the dependencies.

## Running the script
The script takes in two parameters, _--iloip_ and _--username_, and then it would prompt the operator to enter the login password. It then saves the BIOS settings and the firmware inventory to the current working directory.
1. --iloip: iLO IP address
2. --username: iLO login username
```
operator$ python system_baseline_compliance.py --username administrator --iloip 192.168.0.100
password: iLO login password
> 
iLO serial number: MAX63507MJ
Latests baseline: C:\Users\operator\ilorest_pull_data-master\ProLiant_DL360_Gen9_iLO4_MAX63507MJ_bios_20191118-145243.json
Latests baseline: C:\Users\operator\ilorest_pull_data-master\ProLiant_DL360_Gen9_iLO4_MAX63507MJ_firmware_inventory_20191118-145243.json
Save baselines to C:\Users\operator\ilorest_pull_data-master\ProLiant_DL360_Gen9_iLO4_MAX63507MJ_firmware_inventory_diff_20191118-145740.json
Save baselines to C:\Users\operator\ilorest_pull_data-master\ProLiant_DL360_Gen9_iLO4_MAX63507MJ_bios_20191118-145740.json
Save baselines to C:\Users\operator\ilorest_pull_data-master\ProLiant_DL360_Gen9_iLO4_MAX63507MJ_firmware_inventory_20191118-145740.json
```