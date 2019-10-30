## Summary
The goal for the [pull_ilo_data.py](https://github.com/nlin24/ilorest_pull_data/blob/developments/pull_ilo_data.py) script is to download system BIOS settings and firmware inventory information from iLO chassis manager. It connects to the iLO using [Python iLO REST library](https://github.com/HewlettPackard/python-ilorest-library), makes query to the system BIOS configurations and firmware inventory, and then downloads and saves the information in JSON file format. The name of the resulting JSON file contains the system model and the iLO name. The script has been tested with Gen8 iLO4 (iLO4 FW 2.55 Aug 16 2017), Gen9 iLO4 (iLO4 FW 2.61 Jul 27 2018), Gen10 iLO5 (iLO5 FW 1.37 Oct 25 2018), in production mode.
 
## Environment and Setup
This script has been tested on Python 3.8.0 and 3.7.3. Pythons can either be downloaded and installed from [https://www.python.org/downloads/](https://www.python.org/downloads/). Linux users may need to build from source.
Dependencies are listed in _requirements.txt_. Use Pip to install the dependencies.
```
operator$ python --version
Python 3.8.0
operator$ pip install -r requirements.txt
```
## Running the script
The script takes in two parameters, _--iloip_ and _--username_, and then it would prompt the operator to enter the login password. It then saves two JSON files to your local directory, one containing the BIOS configurations, and one for the firmware inventory information.
1. --iloip: iLO IP address
2. --username: iLO login username
```
operator$ python pull_ilo_data.py --username administrator --iloip 192.168.0.100
password: iLO login password
> 
MXQ63507MJ
Save BIOS settings to /home/operator/ilorest_pull_configs/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios.json
Save firmware inventory to /home/operator/ilorest_pull_configs/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory.json
 
```
 