::Test case 4: Run against Gen9 iLo4 with JSON baselines already on current working directory, one for BIOS and one for firmware inventory.
::Does not revise any of the JSON baselines.
::Expected to create two new JSONs, one for BIOS settings and one for firmware inventory, with later date time stamps. No diff JSON report.
dir
python ../system_baseline_compliance.py --iloip 10.188.1.201 --username usradmin
dir

GOTO skipCMDoutput
:: cmd output

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ test4.cmd

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  02:41 PM    <DIR>          .
11/18/2019  02:41 PM    <DIR>          ..
11/18/2019  02:41 PM            15,370 ILO_API.log
11/18/2019  02:41 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144103.json
11/18/2019  02:41 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144103.json
11/18/2019  02:37 PM               850 test1.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:43 PM               466 test4.cmd
               7 File(s)         27,724 bytes
               2 Dir(s)  74,802,491,392 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ python ../system_baseline_compliance.py --iloip 10.188.1.201 --username usradmin
password: iLO login password
>
iLO serial number: MXQ63507MJ
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144103.json
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144103.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144351.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144351.json

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  02:43 PM    <DIR>          .
11/18/2019  02:43 PM    <DIR>          ..
11/18/2019  02:43 PM            22,735 ILO_API.log
11/18/2019  02:41 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144103.json
11/18/2019  02:43 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144351.json
11/18/2019  02:41 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144103.json
11/18/2019  02:43 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144351.json
11/18/2019  02:37 PM               850 test1.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:43 PM               466 test4.cmd
               9 File(s)         42,420 bytes
               2 Dir(s)  74,802,249,728 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ GOTO skipCMDoutput

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$

:skipCMDoutput
