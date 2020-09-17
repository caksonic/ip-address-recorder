#!/bin/bash
#Vol 1.0.3
#Author Ante Perić
#mail to: peric.pericante@gmail.com
#         anteperic@protonmail.com   

search_by_date(){
clear	
echo ""
echo "$(tput setaf 6)Please For Date Search Use: ""Y - M - d"" Format: Like 2020-08-12$(tput sgr 0)"
echo ""
read -p "$(tput setaf 1)Please Enter Date: $(tput sgr 0)" datum
echo ""
datum_1=$(mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
WHERE d_of_c LIKE '$datum%';" shell_ip_address_recorder) 
if [[ -z "$datum" ]]; then
clear
echo ""
echo "$(tput setaf 1)Warnning - Empty Date - Not Allowed$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
elif [[ -z "$datum_1" ]];then
echo "$(tput setaf 1)No Data$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
else
echo ""
mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
WHERE d_of_c LIKE '$datum%';" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
fi
}

search_by_ip(){
clear	
echo ""
echo "$(tput setaf 6)Please For IP Search Use: ""x.x.x.x"" Format: Like 5.133.5.65$(tput sgr 0)"
echo ""
read -p "$(tput setaf 1)Please Enter IP Address: $(tput sgr 0)" adresa
echo ""
adresa_1=$(mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
WHERE address LIKE '$adresa%';" shell_ip_address_recorder) 
if [[ -z "$adresa" ]]; then
clear
echo ""
echo "$(tput setaf 1)Warnning - Empty IP Address - Not Allowed$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
elif [[ -z "$adresa_1" ]];then
echo "$(tput setaf 1)No Data$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
else
echo ""
mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
WHERE address LIKE '$adresa%';" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
fi
}

custom_list_between_date(){
clear	
echo ""
echo "$(tput setaf 6)Custom List - By Date - List IP Address's Between Two Dates$(tput sgr 0)"
echo ""

read -p "$(tput setaf 1)Please Insert First Date:$(tput sgr 0) $(tput setaf 6)(Like: 2020-09-01)$(tput sgr 0) $(tput setaf 1):$(tput sgr 0) " date_1
echo ""

read -p "$(tput setaf 1)Please Insert Second Date:$(tput sgr 0) $(tput setaf 6)(Like: 2020-09-22)$(tput sgr 0) $(tput setaf 1):$(tput sgr 0) " date_2
echo ""

custom_pretraga=$(mysql  -sN -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
WHERE d_of_c BETWEEN '$date_1' AND '$date_2';" shell_ip_address_recorder) > /dev/null

if [[ -z "$date_1" ]] || [[ -z "$date_2" ]]; then
echo "$(tput setaf 1)Warnning - Please Enter:$(tput sgr 0)  $(tput setaf 6)Start / End Date$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'

elif [[ -z "$custom_pretraga" ]];then
echo "$(tput setaf 1)Warnning:$(tput sgr 0) $(tput setaf 6)No Data For Requested Query $(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
else
mysql  -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
WHERE d_of_c BETWEEN '$date_1' AND '$date_2';" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
fi

}

custom_list_select_row(){
	return
}
custom_list(){
while true; do
clear
COLUMNS=$(tput cols)
title="$(tput setaf 6)CaksSonicDeveloper -  A & A Consulting$(tput sgr 0)"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
echo ""
title_1="$(tput setaf 6)Custom List$(tput sgr 0)"
printf "%*s\n" $(((${#title_1}+$COLUMNS)/2)) "$title_1"
echo ""
cat <<_EOF_

Please Select:
 ____________________________________________________________
|                                                            |
| 1. List First $(tput setaf 6)XYZ$(tput sgr 0) Row's       4. Select Between Date's     |
|                                                            | 
| 2. List Last $(tput setaf 6)XYZ$(tput sgr 0) Row's        5. Return To List Record Menu|
|                                                            | 
| 3. Select Start And End Row   6. Return To Main Menu       |
|____________________________________________________________|

$(tput setaf 1)0. Quit$(tput sgr 0)
_EOF_

echo ""
read -p "Enter selection [0 - 6] > "
echo ""
if [[ $REPLY =~ ^[0-6]$ ]]; then
case $REPLY in
1)
clear
echo "$(tput setaf 6)List First 'XYZ' Row's$(tput sgr 0)"
echo ""
read -p "$(tput setaf 6)Please Enter Start Number For Query: $(tput sgr 0)" first_number
echo ""
clear
echo ""
mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
ORDER BY ip_address LIMIT $first_number;" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
;;

2)
clear
echo "$(tput setaf 6)List Last 'XYZ' Row's$(tput sgr 0)"
echo ""
read -p "$(tput setaf 6)Please Enter Start Number For Query: $(tput sgr 0)" last_number
echo ""
clear
echo ""
mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
ORDER BY ip_address  DESC LIMIT $last_number;" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
;;

3)
clear	
echo ""
echo "$(tput setaf 6)Custom List - Between Row's - List IP Address's Between Two Row's$(tput sgr 0)"
echo ""

read -p "$(tput setaf 1)Please Insert First Row - Lower Value:$(tput sgr 0) " row_1
echo ""

read -p "$(tput setaf 1)Please Insert Second Row - Higher Value:$(tput sgr 0) " row_2
echo ""

custom_pretraga_row=$(mysql  -sN -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
WHERE ip_address BETWEEN '$row_1' AND '$row_2';" shell_ip_address_recorder) > /dev/null

if [[ -z "$row_1" ]] || [[ -z "$row_2" ]]; then
echo "$(tput setaf 1)Warnning - Please Enter:$(tput sgr 0)  $(tput setaf 6)Start - Lower Value / End - Higher Value Row$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'

elif [[ -z "$custom_pretraga_row" ]];then
echo "$(tput setaf 1)Warnning:$(tput sgr 0) $(tput setaf 6)No Data For Requested Query $(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
else
mysql  -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
WHERE ip_address BETWEEN '$row_1' AND '$row_2';" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
fi
;;
4)
custom_list_between_date
;;
5)
list_records_main
;;

6)
ip_recorder_user_root
;;
0)
echo "Program Terminated"
sleep 1
exit 0
esac
else
echo "Invalid Entry"
sleep 2
fi
done
}

save_into_file(){
while true; do
clear
COLUMNS=$(tput cols)
title="$(tput setaf 6)CaksSonicDeveloper -  A & A Consulting$(tput sgr 0)"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
echo ""
title_1="$(tput setaf 6)Save Database Record's Into A File$(tput sgr 0)"
printf "%*s\n" $(((${#title_1}+$COLUMNS)/2)) "$title_1"

cat <<_EOF_

Please Select:
 _______________________________________
|                                       |  
| 1. Save Record's In Custom Directory  |
|                                       |
| 2. Save Record's In Default Directory |
|                                       |
| 3. Back To Main Menu                  |
|_______________________________________|

$(tput setaf 1)0. Quit$(tput sgr 0)
_EOF_

echo ""
read -p "Enter Selection [0-3] > "
echo ""
if [[ $REPLY =~ ^[0-3]$ ]]; then
case $REPLY in

1)
read -p "$(tput setaf 6)Please Enter Directory Path - Like /home/$USER/ip-address:$(tput sgr 0) " put
file_b1="$put"
file_b2="$file_b1/list_record_$(date +"%H:%M-%d-%m-%Y").txt" 
echo ""
if [[ -z "$put" ]]; then
echo "$(tput setaf 1)Warnning: Please Enter Directory Path$(tput sgr 0)"

sleep 2
else
echo "Choosen Path Is:  $(tput setaf 2)$put$(tput sgr 0)"
echo ""
sleep 1
if [[ -d "$put" ]]; then

if [[ -f "$file_b2" ]]; then
echo "$(tput setaf 1)Warnning: File $file_b2 All Ready Exist$(tput sgr 0)"
echo ""
echo "$(tput setaf 1)Remove File Or Wait One Minute$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
else
mysql -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address;" shell_ip_address_recorder > "$file_b2"
#chmod 755 "$file_b2"
if [[ -f "$file_b2" ]]; then
echo "$(tput setaf 2)Success: File Created$(tput sgr0)"
sleep 2
else
echo "$(tput setaf 1)Warnning: File Not Created$(tput sgr 0)"
sleep 2
fi
fi
else
echo "$(tput setaf 1)Warnning: Choosen Directory$(tput sgr 0) $(tput setaf 2)$put$(tput sgr 0) $(tput setaf 1)Does Not Exits - Please Choose Existing Directory$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
fi
fi
;;

2)
echo "$(tput setaf 6)Default Directory For Save Database Record's Is: /tmp/ip-address$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
while true; do
clear
echo ""
echo "Please Choose: "
cat <<_EOF_ 
__________________________
 
| 1. YES - Create File    |

| 2. NO  - Back To Menu   | 
___________________________

0. Quit
_EOF_

read -p "Enter Selection [0-2] > "
echo "" 
if [[ $REPLY =~ ^[0-2]$ ]]; then
case $REPLY in
1)
if [[ -d  /tmp/ip-address ]]; then
echo "$(tput setaf 6)That's Cool$(tput sgr 0) $(tput setaf 1)/tmp/ip-address/$(tput sgr 0) $(tput setaf 6)Directory  All Ready Exist$(tput sgr 0)"
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
else
echo "$(tput setaf 6)Let's Create Directory$(tput sgr 0)"
sleep 1
mkdir /tmp/ip-address
chmod 755 /tmp/ip-address
fi

file_b="/tmp/ip-address/list_record_$(date +"%H:%M-%d-%m-%Y").txt" 

if [ -f "$file_b" ]; then
echo "$(tput setaf 1)Warnning: File $file_b  All Ready Exist$(tput sgr 0)"
echo ""
sleep 2
echo "$(tput setaf 1)Remove File $file_b Or Wait One Minute$(tput sgr 0)" 
else
mysql -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date_Of_Creation'
FROM address;" shell_ip_address_recorder >> "$file_b"
chmod 755 "$file_b"
if [[ -f "$file_b" ]]; then
echo "$(tput setaf 2)Success: File Created$(tput sgr 0)"
sleep 2
else
echo "$(tput setaf 1)Warnning: File Not Created$(tput sgr 0)"
sleep 2
fi
fi
;;


2)
save_into_file
;;

0)
echo "Program Terminated"
exit 0
esac
else
echo "Invalid Entry"
sleep 2
fi
done
;;

3)
ip_recorder_user_root
;;
0)
echo "Program Terminated"
sleep 1
exit 0
esac
else
echo "Invalid Entry"
sleep 2
fi
done	
}

list_records_main(){
while true; do
clear

COLUMNS=$(tput cols)
title="$(tput setaf 6)CaksSonicDeveloper -  A & A Consulting$(tput sgr 0)"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
echo ""
title_1="$(tput setaf 6)List Recorded IP's$(tput sgr 0)"
printf "%*s\n" $(((${#title_1}+$COLUMNS)/2)) "$title_1"
echo ""

cat <<_EOF_
Please Select:  
 ____________________________________________________
|                                                    | 
| 1. List  All         5. Search                     |
| 2. List First 10     6. Back To Recorded IP Menu   |
| 3. List Last 10                                    |
| 4. Custom List                                     |
|____________________________________________________|

$(tput setaf 1)0. Quit$(tput sgr 0)
_EOF_

echo ""
read -p "Enter selection [0 - 6] > "
echo ""
if [[ $REPLY =~ ^[0-6]$ ]]; then
case $REPLY in
1)
clear
echo "$(tput setaf 6)Current List Of IP Address's$(tput sgr 0)"
echo ""

lista=$(mysql  -sN -u root -p$(cat /etc/ip_recorder.txt) -e "
SET @broj=(SELECT COUNT(ip_address) FROM address);
SELECT @broj AS 'Broj';" shell_ip_address_recorder) > /dev/null

echo "Number Of Current Record's Is: $(tput setaf 6)$lista$(tput sgr 0)"
echo ""
mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address;" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
;;

2)
clear
echo "$(tput setaf 6)First 10 IP's$(tput sgr 0)"
echo ""
mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address
ORDER BY ip_address LIMIT 10;" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
;;

3)
clear
echo "$(tput setaf 6)Last  10 IP's$(tput sgr 0)"
echo ""
mysql -s -u root -p$(cat /etc/ip_recorder.txt) -e "
SELECT ip_address AS 'ID', address AS 'IP Address', d_of_c AS 'Date Of Creation'
FROM address  
ORDER BY ip_address DESC LIMIT 10;" shell_ip_address_recorder
echo ""
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
;;

4)
custom_list
;;

5)

while true; do
clear
COLUMNS=$(tput cols)
title="$(tput setaf 6)CaksSonicDeveloper -  A & A Consulting$(tput sgr 0)"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
echo ""
title_1="$(tput setaf 6)Search Menu$(tput sgr 0)"
printf "%*s\n" $(((${#title_1}+$COLUMNS)/2)) "$title_1"
echo ""

cat <<_EOF_
Please Select:
 _______________________________________________________
|                                                       | 
| 1. Search By Date        3. Back To List Recorded Menu|
| 2. Search By IP Address  4. Back To Main Menu         |
|_______________________________________________________|

$(tput setaf 1)0. Quit$(tput sgr 0)
_EOF_

echo ""
read -p "Enter selection [0 - 4] > "
echo ""
if [[ $REPLY =~ ^[0-4] ]]; then
case $REPLY in

1)
search_by_date
;;

2)
search_by_ip
;;

3)
list_records_main
;;

4)
ip_recorder_user_root
;;

0)
echo "Program Terminated "
sleep 1
exit 0
esac
else
echo "Invalid Entry"
sleep 2
fi
done
;;

6)
ip_recorder_user_root
return
;;


0)
echo "Program Terminated"
sleep 2
exit 0
esac
else
echo "Invalid Entry"
sleep 2
fi
done
}

insert_records(){
while true; do
clear;
echo ""
ip_adresa=$(curl ipinfo.io/ip 2>/dev/null)
echo -e  "Current IP: $(tput setaf 2)$ip_adresa$(tput sgr 0)"


echo ""
cat << _EOF_
Please Select:
 __________________________
|                          |
| 1. Insert IP Address     |
| 2. Return to Main Menu   |
|__________________________|

$(tput setaf 1)0.Quit$(tput sgr 0)
_EOF_

echo ""
read -p "Enter selection [0-1] > "
echo ""

if [[ $REPLY =~ ^[0-2]$ ]]; then
case $REPLY in

1)
#zaporka=$(cat /etc/ip_recorder.txt)
mysql -u root -p$(cat /etc/ip_recorder.txt) -e "
INSERT INTO address (ip_address, address, d_of_c)
VALUES
(NULL, '$ip_adresa', CURRENT_TIMESTAMP);" shell_ip_address_recorder
echo "$(tput setaf 2)IP Address Inserted$(tput sgr 0)"
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
ip_recorder_user_root
return 
;;

2)
ip_recorder_user_root
return
;;
0)
echo "Program Terminated"
sleep 2
exit 0
esac
else
echo "Invalid entry"
sleep 2
fi
done
}

file_exist(){
file=/etc/ip_recorder.txt
if [[ -f "$file" ]]; then
ip_recorder_user_root
else
check_prerequisite
fi
}


mysql_secure(){
	
read -s -p "Enter password: " pass_1
echo ""

if [[ -z "$pass_1" ]]; then
echo "$(tput setaf 1)Warning: Empty Password - Not Allowed$(tput sgr 0)"
echo ""
while true; do
cat << _EOF_
Please Select: 
 ____________________
|                    | 
| 1. Insert Password |
|                    |
| 0. Exit            |
|____________________|
_EOF_

echo ""
read -p "Enter selection: [0 - 1] > "
echo ""
if [[ $REPLY =~ ^[0-1]$ ]]; then
case $REPLY in
1)
mysql_secure
return
;;
0)
break
;;
esac
else
echo "Invalid Entry"
sleep 2
clear
fi
done
else
read -s -p "Repeat Password: " pass_2
sleep 2
echo ""
if [[ "$pass_1" == "$pass_2" ]]; then
echo -e  "\n y\n y\n $pass_1\n $pass_1\n y\n y\n y\n y" | /usr/bin/mysql_secure_installation &> /dev/null
echo "$(tput setaf 2)Database Password Is Set$(tput sgr 0)"
sleep 2
cat <<< "$pass_1" > /etc/ip_recorder.txt
create_database
else
echo "$(tput setaf 1)Warning:  Password Did Not Match$(tput sgr 0)"
sleep 2
clear 

while true; do
cat << _EOF_
Please select: 

 __________________________
|                          |
| 1. Insert Again Password |
|                          | 
| 0. Quit                  |
|__________________________|

_EOF_

read -p "Enter selection [0-1] > "
if [[ $REPLY =~ ^[0-1]$ ]]; then
case $REPLY in
1)
mysql_secure
return
;;
0)
break
;;
esac
else
echo "Invalid Entry"
sleep 2
clear
fi
done
echo "Program Terminated"
sleep 2
fi	
fi
}

cre_database_exist_10_3(){
echo ""	
echo "$(tput setaf 6) Let's Create Database$(tput sgr 0)"
sleep 2
echo ""	
read -s -p "Enter Your root Password: " zaporka
echo ""
mysql -u root -p$zaporka -e ";" 2> /root/error.txt > /dev/null
cat <<< "$zaporka" > /etc/ip_recorder.txt


if [[ -s /root/error.txt ]]; then
echo "$(tput setaf 6) Something Wrong - Insert Correct Password$(tput sgr 0)"
sleep 2
rm -rf /root/error.txt
while true; do
clear
#echo -e "$(tput setaf 1)Insert root Password(tput sgr 0)"
cat << _EOF_

$(tput setaf 6)Please Select: 

 ______________________ 
|                      |
| 1. Insert Password   |
|                      |
| 0. Quit              |
|______________________|

$(tput sgr 0)
_EOF_
read -p "Enter selection [ 0 - 1 ] > "
if [[ $REPLY =~ ^[0-1]$ ]]; then
case $REPLY in
1)
cre_database_exist_10_3
return 
;;
0)
break
;;
esac
else
echo "Invalid Entry"
sleep 2
fi
done
echo "Program terminated"
sleep 1
else
mysql -u root -p$zaporka -e " \
CREATE DATABASE IF NOT EXISTS shell_ip_address_recorder CHARACTER SET utf8 COLLATE utf8_general_ci;" 
sleep 2
var_baza=$(mysql -u root -p$zaporka -e "show databases;")
if [[ "$var_baza" == *"shell_ip_address_recorder"* ]]; then
echo "$(tput setaf 2)Done - Create Database$(tput sgr 0)"
sleep 2
else
echo "Something Is Wrong"
exit 1
fi

mysql -u root -p"$zaporka" -e "
CREATE TABLE address (
ip_address INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(16) NOT NULL,
d_of_c TIMESTAMP
);" shell_ip_address_recorder
sleep 2
echo "$(tput setaf 2)Done - Create Table$(tput sgr 0)"
sleep 2
echo "$(tput setaf 2)Installation Compleate$(tput sgr 0)"
sleep 3
rm -rf /root/error.txt
fi
}

cre_database_exist_10_4(){
echo ""	
echo "$(tput setaf 6) Let's Create Database$(tput sgr 0)"
sleep 2
echo ""	
read -s -p "Enter Your root Password: " zaporka
echo ""
mysql -u root -p$zaporka -e ";" 2> /root/error.txt > /dev/null
cat <<< "$zaporka" > /etc/ip_recorder.txt


if [[ -s /root/error.txt ]]; then
echo "$(tput setaf 6) Something Wrong - Insert Correct Password$(tput sgr 0)"
sleep 2
rm -rf /root/error.txt
while true; do
clear
#echo -e "$(tput setaf 1)Insert root Password(tput sgr 0)"
cat << _EOF_

$(tput setaf 6)Please Select: 

 ______________________ 
|                      |
| 1. Insert Password   |
|                      |
| 0. Quit              |
|______________________|

$(tput sgr 0)
_EOF_
read -p "Enter selection [ 0 - 1 ] > "
if [[ $REPLY =~ ^[0-1]$ ]]; then
case $REPLY in
1)
cre_database_exist_10_3
return 
;;
0)
break
;;
esac
else
echo "Invalid Entry"
sleep 2
fi
done
echo "Program terminated"
sleep 1
else
mysql -u root -p$zaporka -e " \
CREATE DATABASE IF NOT EXISTS shell_ip_address_recorder CHARACTER SET utf8 COLLATE utf8_general_ci;" 
sleep 2
var_baza=$(mysql -u root -p$zaporka -e "show databases;")
if [[ "$var_baza" == *"shell_ip_address_recorder"* ]]; then
echo "$(tput setaf 2)Done - Create Database$(tput sgr 0)"
sleep 2
else
echo "Something Is Wrong"
exit 1
fi

mysql -u root -p"$zaporka" -e "
CREATE TABLE address (
ip_address INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(16) NOT NULL,
d_of_c TIMESTAMP
);" shell_ip_address_recorder
sleep 2
echo "$(tput setaf 2)Done - Create Table$(tput sgr 0)"
sleep 2
echo "$(tput setaf 2)Installation Compleate$(tput sgr 0)"
sleep 3
rm -rf /root/error.txt
fi
}



#IP Recorder Funkcija - 

ip_recorder_user_root(){
echo ""
#echo -e "  $(tput setaf 6)IP ADDRESS RECORDER$(tput sgr 0)"

while true; do
clear;
COLUMNS=$(tput cols)
title="$(tput setaf 6)CaksSonicDeveloper -  A & A Consulting$(tput sgr 0)"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
echo ""
title_1="$(tput setaf 6)IP ADDRESS RECORDER - MAIN MENU$(tput sgr 0)"
printf "%*s\n" $(((${#title_1}+$COLUMNS)/2)) "$title_1"


echo ""
cat << _EOF_
Please Select: 

 ________________________________________________
|                         |                      |            
| 1. List Recorderd IP's  | 3. Save Into File    |                      
| 2. Insert IP 	          | 4. About Application |                                          
|_________________________|______________________|

0. $(tput setaf 1)Quit$(tput sgr 0)
_EOF_
 
echo ""
read -p "Enter selection [0-5] > "
echo ""
if [[ $REPLY =~ ^[0-5]$ ]]; then
case $REPLY in

1)
list_records_main
return
;;

2)
insert_records
return
;;

3)
save_into_file
return
;;

4)
cat <<_EOF_

IP-Address is simple app writen in bash shell program. This app collect on user request IP Address from your ISP.
,...
_EOF_
read  -t 600 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
;;

0)
echo "Program Terminated"
sleep 2
exit 0
esac
else
echo "Invalid Entry!"
sleep 2
fi
done
}



install_mariadb_centos_7(){	
echo "Create MariaDB Repository File"	
sleep 2	
cat > /etc/yum.repos.d/MariaDB.repo << _EOF_
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.4/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
_EOF_

if  ls /etc/yum.repos.d/ | grep MariaDB.repo  > /dev/null ;then
echo "$(tput setaf 2)Success: File Created$(tput sgr 0)"
else
echo "(tput setaf 1)Error: File Not Created$(tput sgr 0)"
exit 1
fi
sleep 2

echo "Install Prerequisite Packages"
sleep 2
#Pocetne varijable
var_yum_utils=$(rpm -qa yum-utils)
var_wget=$(rpm -qa wget)
var_curl=$(rpm -qa curl)

#Provjera za yum-utils
if [[ -z "$var_yum_utils" ]] > /dev/null ;then
echo "$(tput setaf 1)Package yum-utils Isn't Installed, Manager Will Install It$(tput sgr 0)"
sleep 2
yum -y install yum-utils > /dev/null
var_yum_utils_1=$(rpm -qa yum-utils)
if [[ -z "$var_yum_utils_1" ]]; then
echo "$(tput setaf 2)Unknown Error, Manager Could't Install yum-utils package$(tput sgr 0)"
exit 1
else
echo "$(tput setaf 2)yum-utils OK$(tput sgr 0)"
fi
else
echo "$(tput setaf 2)yum-utils  OK$(tput sgr 0)"
fi
#Kraj za yum-utils

#Provjera za wget
if [[ -z "$var_wget" ]] > /dev/null ;then
echo "$(tput setaf 1)Package wget Isn't Installed, Manager Will Install It$(tput sgr 0)"
sleep 2
yum -y install wget > /dev/null
var_wget_1=$(rpm -qa wget)
if [[ -z "$var_wget_1" ]]; then
echo "$(tput setaf 2)Unknown Error, Manager Could't Install wget package$(tput sgr 0)"
exit 1
else
echo "$(tput setaf 2)wget OK$(tput sgr 0)"
fi
else
echo "$(tput setaf 2)wget  OK$(tput sgr 0)"
fi
#Kraj za wget

#Provjera za curl
if [[ -z "$var_curl" ]] > /dev/null ;then
echo "$(tput setaf 1)Package curl Isn't Installed, Manager Will Install It$(tput sgr 0)"
sleep 2
yum -y install curl > /dev/null
var_curl_1=$(rpm -qa curl)
if [[ -z "$var_curl_1" ]]; then
echo "$(tput setaf 2)Unknown Error, Manager Could't Install curl package$(tput sgr 0)"
exit 1
else
echo "$(tput setaf 2)curl OK$(tput sgr 0)"
fi
else
echo "$(tput setaf 2)curl  OK$(tput sgr 0)"
fi


echo "Create Makecache"
yum makecache &> /dev/null 

#Instalacija MariaDB
echo "Installation Of Maria Database - 10.4"
sleep 2
yum -y install MariaDB-server MariaDB-client &> /dev/null
sleep 2

#Provjera da li je instalirana
if yum list installed | grep MariaDB-server.x86_64 >/dev/null; then
echo "$(tput setaf 2)Success! Database Instaled$(tput sgr 0)"
sleep 2
echo "$(tput setaf 2)Database Version: $(mysql -V)$(tput sgr 0)"
sleep 2
else
echo "$(tput setaf 1)Error: Database Not Exist:$(tput sgr 0)"
exit 1
fi

sleep 2
echo "Start and Enable Maria Database Server"
sleep 2
systemctl enable mariadb &> /dev/null
systemctl start mariadb  &> /dev/null
sleep 2
var_2=$(systemctl status mariadb)


if [[ "$var_2" == *"Active: active (running)"* ]]; then
echo "$(tput setaf 2)Success: MariaDB Active$(tput sgr 0)"
sleep 2
else
echo "$(tput setaf 1)Error: MariaDB Inactive$(tput sgr 0)"
sleep 2
exit 1
fi
var_3=$(systemctl status mariadb)
if [[ "$var_3" == *"Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled;"* ]]; then
echo "$(tput setaf 2)Success: MariaDB Enabled$(tput sgr 0)"
sleep 2
else
echo "$(tput setaf 1)Error: MariaDB Disabled$(tput sgr 0)"
sleep 2
exit 1
fi
echo "$(tput setaf 2)Start / Enable Complete$(tput sgr 0)"
sleep 2
echo "$(tput setaf 1)Please Setup Your MariaDB Password - Keep It Strong!!!$(tput sgr 0)"
sleep 2
mysql_secure
#Može i ovako:
<<comment_1
mysql_secure_installation <<EOF
n
y
password
password
y
y
y
y
comment_1
}

install_mariadb_centos_8(){
echo "Create MariaDB Repository File"	
sleep 2
	
cat > /etc/yum.repos.d/MariaDB.repo << _EOF_
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.4/centos8-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
_EOF_
if  ls /etc/yum.repos.d/ | grep MariaDB.repo  > /dev/null ;then
echo "$(tput setaf 2)Success: File Created$(tput sgr 0)"
else
echo "(tput setaf 1)Error: File Not Created$(tput sgr 0)"
exit 1
fi

sleep 2
echo "Install Prerequisite Packages"
sleep 2
#Pocetne varijable

var_wget=$(rpm -qa wget)
var_curl=$(rpm -qa curl)
var_galera_4=$(rpm -qa galera-4)

#Provjera za wget
if [[ -z "$var_wget" ]] > /dev/null ;then
echo "$(tput setaf 1)Package wget Isn't Installed, Manager Will Install It$(tput sgr 0)"
sleep 2
yum -y install wget > /dev/null
var_wget_1=$(rpm -qa wget)
if [[ -z "$var_wget_1" ]]; then
echo "$(tput setaf 2)Unknown Error, Manager Could't Install wget package$(tput sgr 0)"
exit 1
else
echo "$(tput setaf 2)wget OK$(tput sgr 0)"
fi
else
echo "$(tput setaf 2)wget  OK$(tput sgr 0)"
fi
#Kraj za wget
#Provjera za curl
if [[ -z "$var_curl" ]] > /dev/null ;then
echo "$(tput setaf 1)Package curl Isn't Installed, Manager Will Install It$(tput sgr 0)"
sleep 2
yum -y install curl > /dev/null
var_curl_1=$(rpm -qa curl)
if [[ -z "$var_curl_1" ]]; then
echo "$(tput setaf 2)Unknown Error, Manager Could't Install curl package$(tput sgr 0)"
exit 1
else
echo "$(tput setaf 2)curl OK$(tput sgr 0)"
fi
else
echo "$(tput setaf 2)curl  OK$(tput sgr 0)"
fi

#Provjera za galera & lang package
if [[ -z "$var_galera_4" ]] > /dev/null ;then
echo "$(tput setaf 1)Package galera-4 Isn't Installed, Manager Will Install It$(tput sgr 0)"
sleep 2
dnf install langpacks-en glibc-all-langpacks -y  &> /dev/null
dnf -y install galera-4  &> /dev/null
var_galera_4_1=$(rpm -qa galera-4)
if [[ -z "$var_galera_4_1" ]]; then
echo "$(tput setaf 2)Unknown Error, Manager Could't Install galera-4 package$(tput sgr 0)"
exit 1
else
echo "$(tput setaf 2)galera-4 OK$(tput sgr 0)"
fi
else
echo "$(tput setaf 2)galera-4  OK$(tput sgr 0)"
fi
sleep 2




var_11=$(dnf makecache)
if [[ "$var_11" == *"Metadata cache created."* ]]; then
echo "$(tput setaf 2)Metadata Created$(tput sgr 0)"
else
echo "$(tput setaf 1)Warning: Metadata Not Created$(tput sgr 0)"
fi
sleep 2
#Instalacija MariaDB
echo "Installation Of Maria Database - 10.4"
sleep 2
dnf --disablerepo=AppStream -y install MariaDB-server MariaDB-client  &> /dev/null
sleep 2
#Provjera da li je instalirana
if yum list installed | grep MariaDB-server.x86_64 >/dev/null; then
echo "$(tput setaf 2)Success! Database Installed$(tput sgr 0)"
sleep 2
echo "$(tput setaf 2)Database Version: $(mysql -V)$(tput sgr 0)"
sleep 2
else
echo "$(tput setaf 1)Error: Database Not Exist:$(tput sgr 0)"
exit 1
fi

sleep 2
echo "Start and Enable Maria Database Server"
sleep 2
systemctl enable mariadb &> /dev/null
systemctl start mariadb  &> /dev/null
sleep 2
var_2=$(systemctl status mariadb)

if [[ "$var_2" == *"Active: active (running)"* ]]; then
echo "$(tput setaf 2)Success: MariaDB Active$(tput sgr 0)"
sleep 2
else
echo "$(tput setaf 1)Error: MariaDB Inactive$(tput sgr 0)"
sleep 2
exit 1
fi
var_3=$(systemctl status mariadb)
if [[ "$var_3" == *"Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled;"* ]]; then
echo "$(tput setaf 2)Success: MariaDB Enabled$(tput sgr 0)"
sleep 2
else
echo "$(tput setaf 1)Error: MariaDB Disabled$(tput sgr 0)"
sleep 2
exit 1
fi

echo "$(tput setaf 2)Start / Enable Complete$(tput sgr 0)"
sleep 2
echo "$(tput setaf 1)Please Setup Your MariaDB Password - Keep It Strong!!!$(tput sgr 0)"
sleep 2
mysql_secure
}

create_database(){
echo "$(tput setaf 6)Create Database$(tput sgr 0)"
sleep 2
mysql -u root -p"$pass_1" -e " \
CREATE DATABASE IF NOT EXISTS shell_ip_address_recorder CHARACTER SET utf8 COLLATE utf8_general_ci;" 
sleep 2
echo "$(tput setaf 2)Done - Create Database$(tput sgr 0)"
sleep 2

echo "Create Table"
mysql -u root -p"$pass_1" -e "
CREATE TABLE address (
ip_address INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(16) NOT NULL,
d_of_c TIMESTAMP
);" shell_ip_address_recorder

sleep 2
echo "$(tput setaf 2)Done - Create Table$(tput sgr 0)"
sleep 2
echo "$(tput setaf 2)Installation Compleate!$(tput sgr 0)"
sleep 3
}




check_prerequisite(){
		
#var_recorder=$(cat /etc/ip_recorder.txt) > /dev/null
#var_databases=$(mysql -u root -p$var_recorder -e "show databases;") > /dev/null

#if [[ "$var_databases" == *"shell_ip_address_recorder"* ]]; then
#ip_recorder_user_root
#else
#echo ""
#fi	
	
	
	
if ! command -v mysql &>/dev/null; then
echo "$(tput setaf 1)Warning: To Use This Tool MySQL Must Be Installed$(tput sgr 0)"
echo ""
read  -t 60 -n 1 -r -s -p $'Press Any Key To Continue ....\n'

while true; do
echo ""
echo "Do You Want To Continue: "
cat  << _EOF_
$(tput setaf 6)
 __________________
|                  | 
| 1. YES           |
|                  |
| 2. NO            |
|__________________|

$(tput sgr 0)
_EOF_

read -p "Enter selection [1 - 2] > "
echo ""

verzija=$(cat /etc/redhat-release)
jedan="CentOS Linux release 8"
dva="CentOS Linux release 7"
net_1=$(curl ipinfo.io/ip &> /dev/null)

if [[ $REPLY =~ ^[1-2]$ ]]; then
case $REPLY in
1)
echo "$(tput setaf 1)Script Will Install And Setup Database For You, Please Be Patient$(tput sgr 0)"
echo ""
read  -t 60 -n 1 -r -s -p $'Press Any Key To Continue ....\n'
echo ""
if [[ $verzija =~ "$jedan" ]]; then
echo "Your system is: $(tput setaf 6)$verzija$(tput sgr 0) "
echo ""
echo "Check Internet Connection"
sleep 3
if command curl ipinfo.io/ip > /dev/null 2>&1; then
echo "$(tput setaf 2)Internet OK$(tput sgr 0)"
echo ""
sleep 2
#################################################
#Ovdje dolazi funkcija install_mariadb_centos_8
install_mariadb_centos_8
return

else
echo "$(tput setaf 1)Error: No Internet Connection, Program Terminated$(tput sgr 0)"
sleep 2
exit 1
fi

elif [[ $verzija =~ "$dva" ]]; then
echo "Your system is: $(tput setaf 6)$verzija$(tput sgr 0)$(tput sgr 0) "
echo ""
echo "Check Internet Connection"
sleep 3
if command curl ipinfo.io/ip > /dev/null 2>&1; then
echo "$(tput setaf 2)Internet OK$(tput sgr 0)"
echo ""
sleep 2
###########################################################
#Ovdje dolazi funkcija install mariadb_centos_7
install_mariadb_centos_7
return 

else
echo "$(tput setaf 1)Error: No Internet Connection, Program Terminated$(tput sgr 0)"
sleep 3
exit 1
fi
else
echo "$(tput setaf 1)Non Supported OS Version$(tput sgr 0)"
fi
continue
;;
2)
echo "Program Terminated, . . ."
sleep 2
exit 1
;;
esac
else
echo "$(tput setaf 1)Invalid Entry$(tput sgr 0)"
sleep 2
clear
fi
done
else
echo "$(tput setaf 6)MySQL Database Is Installed, That's Cool, Let's Now Create Database$(tput sgr 0)"
sleep 2
var=$(mysql -V)
if [[ "$var" == *"Distrib 10.3"* ]]; then
echo "You Are Using Distribution: "
echo ""
echo "$(tput setaf 2)$var$(tput sgr 0)"
cre_database_exist_10_3
sleep 2
elif [[ "$var" == *"Distrib 10.4"* ]]; then
echo "You Are Using Distribution:"
echo ""
echo "$(tput setaf 2)$var$(tput sgr 0)"
sleep 2 
cre_database_exist_10_4
fi
fi
}

#echo ""
#echo -e "                         - - $(tput setaf 6)IP ADDRESS RECORDER$(tput sgr 0) - - "
echo ""
#check_prerequisite
file_exist
