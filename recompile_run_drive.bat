@echo off
if exist boot_drive.vdi del /F boot_drive.vdi >nul 2>&1
nasm boot_sector.asm -f bin -o boot_sector.bin >nul 2>&1
vboxmanage convertdd boot_sector.bin boot_drive.vdi --format VDI >nul 2>&1
vboxmanage storageattach BrianOS --storagectl IDE --port 0 --device 0 --medium none >nul 2>&1
vboxmanage closemedium disk boot_drive.vdi >nul 2>&1
vboxmanage storageattach BrianOS --storagectl IDE --port 0 --device 0 --medium boot_drive.vdi --type hdd >nul 2>&1
vboxmanage startvm BrianOS >nul 2>&1