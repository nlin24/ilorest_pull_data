::Test case 11: Run against Gen10 iLO5 with Gen10 JSON baselines already on current working directory.
::Make changes to the latest firmware inventory baseline (ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152045)
:: 1. Remove "15b31015159000d3": {"Name": "HPE Eth 10/25Gb 2p 640FLR-SFP28 Adptr - NIC","Version": "14.23.8052"},
:: 2. Change "SPSFirmwareVersionData": {"Name": "Server Platform Services (SPS) Firmware","Version": "4.1.4.251"}, to "Lin": {"Name": "Server Platform Services (SPS) Firmware","Version": "123456"},
:: 3. Change "InnovationEngineFirmware": {"Name": "Innovation Engine (IE) Firmware","Version": "0.2.0.11"}, to "InnovationEngineFirmware": {"Name": "Lin Lin Lin","Version": "Nathan Nathan Nathan"},
::Expected to create three new JSONs, one more iLO5 BIOS and one for iLO5 firmware inventory, with lateer date time stamps. A third one a diff report showing all the changes above and calling the baseline file ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152045

dir
python ../system_baseline_compliance.py --iloip 10.188.1.184 --username v241usradmin
dir

GOTO skipCMDoutput
:: cmd output

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ test11.cmd

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  03:21 PM    <DIR>          .
11/18/2019  03:21 PM    <DIR>          ..
11/18/2019  03:20 PM            97,206 ILO_API.log
11/18/2019  03:18 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-151816.json
11/18/2019  03:20 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152045.json
11/18/2019  03:18 PM             2,252 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-151816.json
11/18/2019  03:25 PM             2,090 ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152045.json
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
11/18/2019  03:25 PM             1,129 test11.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:44 PM             3,829 test4.cmd
11/18/2019  02:55 PM             6,752 test5.cmd
11/18/2019  03:09 PM             7,227 test6.cmd
11/18/2019  03:09 PM             8,138 test7.cmd
11/18/2019  03:16 PM               884 test8.cmd
11/18/2019  03:19 PM             4,215 test9.cmd
              32 File(s)        207,020 bytes
               2 Dir(s)  74,550,759,424 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ python ../system_baseline_compliance.py --iloip 10.188.1.184 --username v241usradmin
password: iLO login password
>
iLO serial number: MXQ734081G
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152045.json
Latests baseline: C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests\ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152045.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_diff_20191118-152601.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152601.json
Save baselines to C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests/ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152601.json

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ dir
 Volume in drive C is PC COE
 Volume Serial Number is A42A-70AC

 Directory of C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests

11/18/2019  03:26 PM    <DIR>          .
11/18/2019  03:26 PM    <DIR>          ..
11/18/2019  03:26 PM           107,234 ILO_API.log
11/18/2019  03:18 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-151816.json
11/18/2019  03:20 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152045.json
11/18/2019  03:26 PM             6,555 ProLiant_DL360_Gen10_iLO5_MXQ734081G_bios_20191118-152601.json
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
11/18/2019  03:25 PM             1,129 test11.cmd
11/18/2019  02:38 PM               866 test2.cmd
11/18/2019  02:41 PM             2,841 test3.cmd
11/18/2019  02:44 PM             3,829 test4.cmd
11/18/2019  02:55 PM             6,752 test5.cmd
11/18/2019  03:09 PM             7,227 test6.cmd
11/18/2019  03:09 PM             8,138 test7.cmd
11/18/2019  03:16 PM               884 test8.cmd
11/18/2019  03:19 PM             4,215 test9.cmd
              35 File(s)        227,166 bytes
               2 Dir(s)  74,550,534,144 bytes free

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ GOTO skipCMDoutput

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$
linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ more ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_diff_20191118-152601.json
{
    "15b31015159000d3": {
        "baseline_file": {
            "Name": null,
            "Version": null
        },
        "current_system": {
            "Name": "HPE Eth 10/25Gb 2p 640FLR-SFP28 Adptr - NIC",
            "Version": "14.23.8052"
        }
    },
    "InnovationEngineFirmware": {
        "baseline_file": {
            "Name": "Lin Lin Lin",
            "Version": "Nathan Nathan Nathan"
        },
        "current_system": {
            "Name": "Innovation Engine (IE) Firmware",
            "Version": "0.2.0.11"
        }
    },
    "Lin": {
        "baseline_file": {
            "Name": "Server Platform Services (SPS) Firmware",
            "Version": "123456"
        },
        "current_system": {
            "Name": null,
            "Version": null
        }
    },
    "SPSFirmwareVersionData": {
        "baseline_file": {
            "Name": null,
            "Version": null
        },
        "current_system": {
            "Name": "Server Platform Services (SPS) Firmware",
            "Version": "4.1.4.251"
        }
    },
    "baseline_file_input": "C:\\Users\\linna\\Downloads\\ilorest_pull_data-master\\ilorest_pull_data-master\\accept_tests\\ProLiant_DL360_Gen10_iLO5_MXQ734081G_firmware_inventory_20191118-152045.json"
}

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$


:skipCMDoutput
