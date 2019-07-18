# zimbra_backup_restore
one for backup and one for restore

If you want to migrate your zimbra server this scripts will help you.

## Table of contents

- [Datas to be backup](#Features)
- [Usage](#Usage)
- [Backup](#Phase-1--Backup)
- [Migrate Data](#Rsync)
- [Restore](#Phase-2--Restore)  
- [Conclusion](#Conclusion)

This repo have two scripts one for backup your zimbra datas(Phase-1) and one for restore the zimbra datas(Phase-2)

## Features
**The backup.sh script backup zimbra datas like**
- Domains
- Admin Account
- Email Account and Passwords
- Distribution Lists and Members
- Alias
- Signatures
- Filter
- Mailbox data

## Usage  

## Phase-1  Backup 
>Backup all your data by following steps

**Login to old server as superuser privileges and follow the steps**

Step 1: Create a folder to save backups and Change owner of the folder to zimbra                      
>For e.g:- my backupfolder is /migration        
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


## Rsync

sync your data from old server to new server with same permission

>From your new server

```bash
	rsync -apv -e ssh root@backup_server_ip:path_to_backup_folder /new_server_path
```
For e.g:- 
old server ip=192.168.1.100  
old server ssh port=22  
old server backup_data folder=/migration  
New server data folder=/migration  
		
```bash
	sudo mkdir /migration
	sudo chown -R zimbra.zimbra /migration
	rsync -apv -e 'ssh -p 22' root@192.168.1.100:/migration /
```
It will sync your data from old server to new server
	

## Phase-2  Restore

Step 1: Enter in to your synced folder
	For e.g:- My folder is /migration then
		
```bash
	su - zimbra
	cd /migration
	wget https://raw.githubusercontent.com/indharajith/zimbra_backup_restore/master/restore.sh
```

Step 2: Define folder having datas in script

```bash
    	vim restore.sh
    	BackupFolder=/migration #change as per yours
```

Step 3: Add execution permission and run

```bash
        chmod +x restore.sh
        ./restore.sh
```

Step 4: Check the restored datas  

## Conclusion  

Finally all your datas are successfully restored from old server to new server  
Note: Use screen command for large datas








