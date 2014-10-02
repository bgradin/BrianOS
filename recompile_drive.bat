@echo off
if "%1"=="" goto no_argument
if exist boot_drive.vdi del /F boot_drive.vdi
cd ..
nasm %1 -f bin -o boot_sector.bin
vboxmanage convertdd boot_sector.bin boot_drive.vdi --format VDI
vboxmanage storageattach BrianOS --storagectl IDE --port 0 --device 0 --medium none
vboxmanage closemedium disk boot_drive.vdi
vboxmanage storageattach BrianOS --storagectl IDE --port 0 --device 0 --medium boot_drive.vdi --type hdd
pause
exit

no_argument:
echo No argument specified. Exiting.
pause