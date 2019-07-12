#!/bin/bash

BackupFolder=/backups/zmigrate

#Checking for zimbra user
USER=`whoami`
if [ $USER != zimbra ];
then
echo "You must be zimbra user now exiting";
sleep 3;
exit 1;
fi

cd $BackupFolder;

#getting all domains
echo "getting all domains";
zmprov gad > $BackupFolder/domains.txt;

#getting all admin account

echo "getting all admin account";
zmprov gaaa > $BackupFolder/admins.txt;

#getting all email account

echo "getting all email account";
zmprov -l gaa > $BackupFolder/emails.txt;

#getting all distribtuin list

echo "getting all distribtuin list";
zmprov gadl > $BackupFolder/distributinlist.txt;

mkdir $BackupFolder/distributinlist_members;

#Getting all dl members

echo "Getting all dl members";
for i in `cat $BackupFolder/distributinlist.txt`;
do
zmprov gdlm $i > $BackupFolder/distributinlist_members/$i.txt;
echo "$i";
done

#getting all user password

mkdir $BackupFolder/userpass;

echo "getting all user password";

for i in `cat emails.txt`;
do
zmprov  -l ga $i userPassword | grep userPassword: | awk '{ print $2}' > $BackupFolder/userpass/$i.shadow;
done


#getting all userdata


mkdir $BackupFolder/userdata


echo "getting all userdata";

for i in `cat $BackupFolder/emails.txt`;
do
zmprov ga $i  | grep -i Name: > $BackupFolder/userdata/$i.txt ;
done


#getting all alias

mkdir -p $BackupFolder/alias/

echo "getting all alias";

for i in `cat $BackupFolder/emails.txt`;
do
zmprov ga  $i | grep zimbraMailAlias |awk '{print $2}' > $BackupFolder/alias/$i.txt ;
echo $i ;
done

find $BackupFolder/alias/ -type f -empty | xargs -n1 rm -v;


#getting all signature

mkdir $BackupFolder/signatures;

echo "getting all signature";

for i in `cat $BackupFolder/emails.txt`; do
        zmprov ga $i zimbraPrefMailSignatureHTML > /tmp/signature;
        sed -i -e "1d" /tmp/signature ;
        sed 's/zimbraPrefMailSignatureHTML: //g' /tmp/signature > $BackupFolder/signatures/$i.signature ;
        rm -rf /tmp/signature;
		`zmprov ga $i zimbraSignatureName > /tmp/name` ;
        sed -i -e "1d" /tmp/name ;
        sed 's/zimbraSignatureName: //g' /tmp/name > $BackupFolder/signatures/$i.name ;
        rm -rf /tmp/name ;
		echo "$i is completed";
done

# getting filters of all email accounts
mkdir $BackupFolder/filter/

echo "getting all filters";

for i in `cat $BackupFolder/emails.txt`; do
    zmprov ga $i zimbraMailSieveScript > /tmp/filter
    sed -i -e "1d" /tmp/filter
    sed 's/zimbraMailSieveScript: //g' /tmp/filter  > $BackupFolder/filter/$i.filter
    rm -f /tmp/filter
    echo "Filter  downloaded for .... $i"
done

#backuping all email accounts

mkdir $BackupFolder/maildata;

for email in `cat $BackupFolder/emails.txt`;
do  
/opt/zimbra/bin/zmmailbox -z -m $email getRestURL '/?fmt=tgz' > $BackupFolder/maildata/$email.tgz ;  
echo "$email is completed" >> $BackupFolder/finished.txt; 
done


echo "###############################################";
echo "Backup successfully completed on $BackupFolder";
echo "###############################################";
