#!/bin/bash

BackupFolder=

#Checking for zimbra user
USER=`whoami`
if [ $USER != zimbra ];
then
echo "You must be zimbra user now exiting";
sleep 3;
exit 1;
fi

cd $BackupFolder;

#Restoring domains

echo "Restoring domains";

for i in `cat $BackupFolder/domains.txt `;
do
zmprov cd $i zimbraAuthMech zimbra;
echo $i;
done

#Restoring email ids and password

echo "Restoring email ids and password";

USERPASS="$BackupFolder/userpass"
USERDDATA="$BackupFolder/userdata"
USERS="$BackupFolder/emails.txt"
for i in `cat $USERS`;
do
givenName=$(grep givenName: $USERDDATA/$i.txt | cut -d ":" -f2);
displayName=$(grep displayName: $USERDDATA/$i.txt | cut -d ":" -f2);
shadowpass=$(cat $USERPASS/$i.shadow);
zmprov ca $i poiuytrewq cn "$givenName" displayName "$displayName" givenName "$givenName"; 
zmprov ma $i userPassword "$shadowpass";
done

#Restoring Admin accounts

echo "Restoring Admin accounts";

for i in `cat $BackupFolder/admins.txt`;
do
echo "changing $i account type";
zmprov ma $i zimbraIsAdminAccount TRUE;
done;

#Restoring DL

echo "Restoring DL";

for i in `cat $BackupFolder/distributinlist.txt`; 
do 
zmprov cdl $i ; 
echo "$i -- done "; 
done

#DL members

echo "Restoring DL members";

for i in `cat $BackupFolder/distributinlist.txt`;
do
	for j in `grep -v '#' $BackupFolder/distributinlist_members/$i.txt |grep '@'`;
	do
	zmprov adlm $i $j;
	echo " $j member has been added to list $i";
	done

done

#Restoring alias

echo "Restoring alias";

for i in `cat $BackupFolder/emails.txt`;
do
	if [ -f "alias/$i.txt" ]; then
	for j in `grep '@' $BackupFolder/alias/$i.txt`
	do
	zmprov aaa $i $j
	echo "$i HAS ALIAS $j --- Restored"
	done
	fi
done

#Restoring Signatures

echo "Restoring Signatures";

for i in `cat $BackupFolder/emails.txt`; do
	zmprov ma $i zimbraSignatureName "`cat signatures/$i.name`";
	zmprov ma $i zimbraPrefMailSignatureHTML "`cat signatures/$i.signature`";
	zmprov ga $i zimbraSignatureId > /tmp/firmaid; sed -i -e "1d" /tmp/firmaid;
	firmaid=`sed 's/zimbraSignatureId: //g' /tmp/firmaid`;
	zmprov ma $i zimbraPrefDefaultSignatureId "$firmaid";
	zmprov ma $i zimbraPrefForwardReplySignatureId "$firmaid";
	rm -rf /tmp/firmaid;
	echo $i "done!";
done

# Restoring Filters

echo "Restoring Filters";

for i in `cat $BackupFolder/emails.txt`; 
do
    zmprov ma  $i zimbraMailSieveScript "`cat filter/$i.filter`";
    echo "Filter Restore for account ... $i"; 
  
done

#Restoring Mailbox

echo "Restoring Mailbox";

for i in `cat $/BackupFolder/emails.txt`; 
do 
/opt/zimbra/bin/zmmailbox -z -m $i postRestURL "/?fmt=tgz&resolve=skip" $BackupFolder/maildata/$i.tgz;  
echo "$i -- finished "; 
done

echo "###############################################";
echo "##############Restored Successfully############";
echo "###############################################";
