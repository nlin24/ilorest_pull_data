::Test case 6: Run against Gen9 iLo4 with JSON baselines already on current working directory, one for BIOS and one for firmware inventory.
::Modify in the latest firmware inventory (ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145243), 
:: 2. Changed PowerManagementControllerBootloader to "PowerManagementControllerBootloader": {"Name": "Nathan","Version": "1.asdfasdf0"},
:: 3. Removed "SystemRomActive": {"Name": "System ROM","Version": "P89 v2.64 (10/17/2018)"},
::Expected to create three new JSONs, one for BIOS settings and one for firmware inventory, with later date time stamps, and lastly one JSON diff report showing 1 -3 and baseline input filename ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145243.
dir
python ../system_baseline_compliance.py --iloip 10.188.1.201 --username usradmin
dir

GOTO skipCMDoutput
:: cmd output

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ test6.cmd

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  02:55 PM    <DIR>          .
11/18/2019  02:55 PM    <DIR>          ..
11/18/2019  02:52 PM            52,279 ILO_API.log
11/18/2019  02:41 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144103.json
11/18/2019  02:43 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144351.json
11/18/2019  02:48 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144856.json
11/18/2019  02:52 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145243.json
11/18/2019  02:41 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144103.json
11/18/2019  02:49 PM             1,786 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144351.json
11/18/2019  02:50 PM             1,786 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144856.json
11/18/2019  02:57 PM             1,891 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145243.json
11/18/2019  02:52 PM               991 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145243.json
11/18/2019  02:37 PM               850 test1.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:44 PM             3,829 test4.cmd
11/18/2019  02:55 PM             6,752 test5.cmd
11/18/2019  02:56 PM               894 test6.cmd
              16 File(s)         98,005 bytes
               2 Dir(s)  74,553,442,304 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ python ../system_baseline_compliance.py --iloip 10.188.1.201 --username usradmin
password: iLO login password
>
iLO serial number: MXQ63507MJ
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145243.json
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145243.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145740.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145740.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145740.json

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  02:57 PM    <DIR>          .
11/18/2019  02:57 PM    <DIR>          ..
11/18/2019  02:57 PM            59,649 ILO_API.log
11/18/2019  02:41 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144103.json
11/18/2019  02:43 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144351.json
11/18/2019  02:48 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-144856.json
11/18/2019  02:52 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145243.json
11/18/2019  02:57 PM             5,303 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_bios_20191118-145740.json
11/18/2019  02:41 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144103.json
11/18/2019  02:49 PM             1,786 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144351.json
11/18/2019  02:50 PM             1,786 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-144856.json
11/18/2019  02:57 PM             1,891 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145243.json
11/18/2019  02:57 PM             2,028 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145740.json
11/18/2019  02:52 PM               991 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145243.json
11/18/2019  02:57 PM               758 ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145740.json
11/18/2019  02:37 PM               850 test1.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:44 PM             3,829 test4.cmd
11/18/2019  02:55 PM             6,752 test5.cmd
11/18/2019  02:56 PM               894 test6.cmd
              19 File(s)        113,464 bytes
               2 Dir(s)  74,554,441,728 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ GOTO skipCMDoutput

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ more ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_diff_20191118-145740.json
{
    "PowerManagementControllerBootloader": {
        "baseline_file": {
            "Name": "Nathan",
            "Version": "1.asdfasdf0"
        },
        "current_system": {
            "Name": "Power Management Controller FW Bootloader",
            "Version": "1.0"
        }
    },
    "SystemRomActive": {
        "baseline_file": {
            "Name": null,
            "Version": null
        },
        "current_system": {
            "Name": "System ROM",
            "Version": "P89 v2.64 (10/17/2018)"
        }
    },
    "baseline_file_input": "C:\\Users\\linna\\Downloads\\ilorest_pull_data-master\\ilorest_pull_data-master\\accept_tests\\ProLiant_DL360_Gen9_iLO4_MXQ63507MJ_firmware_inventory_20191118-145243.json"
}

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$

:skipCMDoutput
