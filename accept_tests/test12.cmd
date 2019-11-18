::Test case 12: Run against Gen10 iLO5 with Gen10 JSON baselines already on current working directory.
::Make changes to the latest BIOS baseline (ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152601)
:: 1. Remove "AcpiHpet": "Disabled",
:: 2. Change "AdvCrashDumpMode": "Disabled", to "AdvCrashDumpMode": "Lin",
:: 3. Remove "LLCDeadLineAllocation": "Enabled", 
:: 4. Add "Nathan": "Lin",
::Expected to create three new JSONs, one more iLO5 BIOS and one for iLO5 firmware inventory, with lateer date time stamps. A third one a BIOS diff report showing all the changes above and calling the baseline file ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152601

dir
python ../system_baseline_compliance.py --iloip 10.188.1.184 --username v241usradmin
dir

GOTO skipCMDoutput
:: cmd output

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ test12.cmd

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  03:31 PM    <DIR>          .
11/18/2019  03:31 PM    <DIR>          ..
11/18/2019  03:26 PM           107,234 ILO_API.log
11/18/2019  03:18 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-151816.json
11/18/2019  03:20 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152045.json
11/18/2019  03:33 PM             6,502 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152601.json
11/18/2019  03:18 PM             2,252 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-151816.json
11/18/2019  03:25 PM             2,090 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152045.json
11/18/2019  03:26 PM             2,252 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152601.json
11/18/2019  03:26 PM             1,311 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_diff_20191118-152601.json
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
11/18/2019  03:21 PM             7,853 test10.cmd
11/18/2019  03:31 PM            11,072 test11.cmd
11/18/2019  03:34 PM               813 test12.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:44 PM             3,829 test4.cmd
11/18/2019  02:55 PM             6,752 test5.cmd
11/18/2019  03:09 PM             7,227 test6.cmd
11/18/2019  03:09 PM             8,138 test7.cmd
11/18/2019  03:16 PM               884 test8.cmd
11/18/2019  03:19 PM             4,215 test9.cmd
              36 File(s)        237,869 bytes
               2 Dir(s)  74,549,260,288 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ python ../system_baseline_compliance.py --iloip 10.188.1.184 --username v241usradmin
password: iLO login password
>
iLO serial number: MXQ734081G
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152601.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_diff_20191118-153429.json
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152601.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-153429.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-153429.json

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  03:34 PM    <DIR>          .
11/18/2019  03:34 PM    <DIR>          ..
11/18/2019  03:34 PM           117,267 ILO_API.log
11/18/2019  03:18 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-151816.json
11/18/2019  03:20 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152045.json
11/18/2019  03:33 PM             6,502 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152601.json
11/18/2019  03:34 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-153429.json
11/18/2019  03:34 PM               594 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_diff_20191118-153429.json
11/18/2019  03:18 PM             2,252 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-151816.json
11/18/2019  03:25 PM             2,090 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152045.json
11/18/2019  03:26 PM             2,252 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152601.json
11/18/2019  03:34 PM             2,252 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-153429.json
11/18/2019  03:26 PM             1,311 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_diff_20191118-152601.json
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
11/18/2019  03:21 PM             7,853 test10.cmd
11/18/2019  03:31 PM            11,072 test11.cmd
11/18/2019  03:34 PM               813 test12.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:44 PM             3,829 test4.cmd
11/18/2019  02:55 PM             6,752 test5.cmd
11/18/2019  03:09 PM             7,227 test6.cmd
11/18/2019  03:09 PM             8,138 test7.cmd
11/18/2019  03:16 PM               884 test8.cmd
11/18/2019  03:19 PM             4,215 test9.cmd
              39 File(s)        257,303 bytes
               2 Dir(s)  74,549,231,616 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ GOTO skipCMDoutput

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$
linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ more ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_diff_20191118-153429.json
{
    "AcpiHpet": {
        "baseline_file": null,
        "current_system": "Disabled"
    },
    "AdvCrashDumpMode": {
        "baseline_file": "Lin",
        "current_system": "Disabled"
    },
    "LLCDeadLineAllocation": {
        "baseline_file": null,
        "current_system": "Enabled"
    },
    "Nathan": {
        "baseline_file": "Lin",
        "current_system": null
    },
    "baseline_file_input": "C:\\Users\\linna\\Downloads\\ilorest_pull_data-master\\ilorest_pull_data-master\\accept_tests\\ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152601.json"
}

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$

:skipCMDoutput
