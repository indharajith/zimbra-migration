# zimbra_backup_restore
one for backup and one for restore

If you want to migrate your zimbra server this scripts will help you.

This repo have two scripts one for backup your zimbra datas(Phase-1) and one for restore the zimbra datas(Phase-2)

**bachkup.sh script backup zimbra datas like**

- Domains
- Admin Account
- Email Account and Passwords
- Distribution Lists and Members
- Alias
- Signatures
- Filter
- Mailbox data

## Phase-1  Backup 
>Backup all your data by following steps

**Login to old server as superuser privileges and follow the steps**

Step 1: Create a folder to save backups and Change owner of the folder to zimbra
        for e.g:- my backupfolder is /migration
        
 ```bash 
        sudo mkdir /migration
        sudo chown -R zimbra.zimbra /migration
        sudo cd /migration
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
Step 5: Verify your data



## Table of contents

- Backup(#Phase-1--Backup)
