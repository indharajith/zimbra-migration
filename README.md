# zimbra_backup_restore
one for backup and one for restore


This script backup zimbra datas like 



Step 1: Create a folder to save backups and Change owner of the folder to zimbra
        for e.g:- my backupfolder is /migration
        
 ```bash 
        mkdir /migration
        chown -R zimbra.zimbra /migration
        cd /migration
```

Step 2: Download the Backup script
```bash
        su - zimbra
        cd /migration
        wget https://raw.githubusercontent.com/indharajith/zimbra_backup_restore/master/backup.sh
```

Step 3: Define folder for saving backup data in script

```bash
        vim backup.sh
        BackupFolder=/migration #change as per yours
```
Step 4: Add execution permission and run

```bash
        chmod +x backup.sh
        ./backup.sh
```
