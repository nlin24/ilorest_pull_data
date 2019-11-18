::Test case 7: Run against Gen9 iLo4 with JSON baselines already on current working directory, one for BIOS and one for firmware inventory.
::Modify in the latest BIOS (ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145740), 
:: 1. Remove "BootOrderPolicy": "RetryIndefinitely",
:: 2. Remove "PowerRegulator": "DynamicPowerSavings",
:: 3. Change "PowerOnLogo": "Enabled", to "NathanLin": "Enabled"
:: 4. Change "ServiceOtherInfo": "", to "ServiceOtherInfo": "Lin Nathan",
::Expected to create three new JSONs, one for BIOS settings and one for firmware inventory, with later date time stamps, and lastly one JSON diff report showing changes, and listing the baseline input filename ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145740.
dir
python ../system_baseline_compliance.py --iloip 10.188.1.201 --username usradmin
dir

GOTO skipCMDoutput
:: cmd output



linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ test7.cmd

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  03:05 PM    <DIR>          .
11/18/2019  03:05 PM    <DIR>          ..
11/18/2019  03:04 PM            67,015 ILO_API.log
11/18/2019  02:41 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144103.json
11/18/2019  02:43 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144351.json
11/18/2019  02:48 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144856.json
11/18/2019  02:52 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145243.json
11/18/2019  03:06 PM             5,220 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145740.json
11/18/2019  02:41 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144103.json
11/18/2019  02:49 PM             1,786 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144351.json
11/18/2019  02:50 PM             1,786 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144856.json
11/18/2019  02:57 PM             1,891 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145243.json
11/18/2019  02:57 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145740.json
11/18/2019  03:04 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-150404.json
11/18/2019  02:52 PM               991 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145243.json
11/18/2019  02:57 PM               758 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145740.json
11/18/2019  02:37 PM               850 test1.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:44 PM             3,829 test4.cmd
11/18/2019  02:55 PM             6,752 test5.cmd
11/18/2019  02:58 PM             7,227 test6.cmd
11/18/2019  03:03 PM               883 test7.cmd
              21 File(s)        129,991 bytes
               2 Dir(s)  74,549,473,280 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ python ../system_baseline_compliance.py --iloip 10.188.1.201 --username usradmin
password: iLO login password
>
iLO serial number: MXQ63507MJ
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145740.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_diff_20191118-150654.json
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-150404.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-150654.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-150654.json

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  03:06 PM    <DIR>          .
11/18/2019  03:06 PM    <DIR>          ..
11/18/2019  03:06 PM            74,381 ILO_API.log
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
11/18/2019  02:58 PM             7,227 test6.cmd
11/18/2019  03:03 PM               883 test7.cmd
              24 File(s)        145,407 bytes
               2 Dir(s)  74,550,476,800 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ GOTO skipCMDoutput

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ more ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_diff_20191118-150654.json
{
    "BootOrderPolicy": {
        "baseline_file": null,
        "current_system": "RetryIndefinitely"
    },
    "NathanLin": {
        "baseline_file": "Enabled",
        "current_system": null
    },
    "PowerOnLogo": {
        "baseline_file": null,
        "current_system": "Enabled"
    },
    "PowerRegulator": {
        "baseline_file": null,
        "current_system": "DynamicPowerSavings"
    },
    "ServiceOtherInfo": {
        "baseline_file": "Lin Nathan",
        "current_system": ""
    },
    "baseline_file_input": "C:\\Users\\linna\\Downloads\\ilorest_pull_data-master\\ilorest_pull_data-master\\accept_tests\\ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145740.json"
}

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$

:skipCMDoutput
