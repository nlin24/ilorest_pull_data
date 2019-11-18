::Test case 9: Run against Gen10 iLO5 without any Gen10 JSON baselines on current working directory.
::Expected to create two new JSONs, one more iLO5 BIOS and one for iLO5 firmware inventory.

python ../system_baseline_compliance.py --iloip 10.188.1.184 --username v241usradmin

GOTO skipCMDoutput
:: cmd output

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ test9.cmd

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ python ../system_baseline_compliance.py --iloip 10.188.1.184 --username v241usradmin
password: iLO login password
>
iLO serial number: MXQ734081G
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-151816.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-151816.json

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ GOTO skipCMDoutput

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  03:18 PM    <DIR>          .
11/18/2019  03:18 PM    <DIR>          ..
11/18/2019  03:18 PM            87,177 ILO_API.log
11/18/2019  03:18 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-151816.json
11/18/2019  03:18 PM             2,252 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-151816.json
11/18/2019  02:41 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144103.json
11/18/2019  02:43 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144351.json
11/18/2019  02:48 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144856.json
11/18/2019  02:52 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145243.json
11/18/2019  03:06 PM             5,220 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145740.json
11/18/2019  03:06 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-150654.json
11/18/2019  03:06 PM               719 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_diff_20191118-150654.json
11/18/2019  02:41 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144103.json
11/18/2019  02:49 PM             1,786 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144351.json
11/18/2019  02:50 PM             1,786 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144856.json
11/18/2019  02:57 PM             1,891 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145243.json
11/18/2019  02:57 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145740.json
11/18/2019  03:04 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-150404.json
11/18/2019  03:06 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-150654.json
11/18/2019  02:52 PM               991 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145243.json
11/18/2019  02:57 PM               758 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145740.json
11/18/2019  02:37 PM               850 test1.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:44 PM             3,829 test4.cmd
11/18/2019  02:55 PM             6,752 test5.cmd
11/18/2019  03:09 PM             7,227 test6.cmd
11/18/2019  03:09 PM             8,138 test7.cmd
11/18/2019  03:16 PM               884 test8.cmd
11/18/2019  03:18 PM               331 test9.cmd
              28 File(s)        175,480 bytes
               2 Dir(s)  74,553,995,264 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$

:skipCMDoutput
