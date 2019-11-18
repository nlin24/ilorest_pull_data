::Test case 1: Input wrong password
::Expected to return an error message and then terminate script
python ../system_baseline_compliance.py --iloip 10.188.1.201 --username usradmin

GOTO skipCMDoutput
linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ test1.cmd

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ python ../system_baseline_compliance.py --iloip 10.188.1.201 --username usradmin
password: iLO login password
>
iLO login failed. Check username and password. Script exited.

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$ GOTO skipCMDoutput

linna@FICRUX1HMJ C:\Users\linna\Downloads\ilorest_pull_data-master\ilorest_pull_data-master\accept_tests
$
:skipCMDoutput
