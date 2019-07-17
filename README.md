# zimbra_backup_restore
one for backup and one for restore


Step 1: Create a folder to save backups and Change owner of the folder to zimbra
        for e.g:- my backupfolder is /migration
        
 ```bash 
        mkdir /migration
        chown -R zimbra.zimbra /migration
```
        

curl https://raw.githubusercontent.com/indharajith/zimbra_backup_restore/master/backup.sh


### Define folder for saving backup data
BackupFolder=path to the folder

