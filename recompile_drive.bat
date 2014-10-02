@echo off
if "%1"=="" goto no_argument

cd %~dp1
if not exist bin\NUL mkdir bin

nasm %~nx1 -f bin -o bin\boot_sector.bin

cd bin
if exist boot_drive.vdi del /F boot_drive.vdi
vboxmanage convertdd boot_sector.bin boot_drive.vdi --format VDI
vboxmanage storageattach BrianOS --storagectl IDE --port 0 --device 0 --medium none
vboxmanage closemedium disk boot_drive.vdi
vboxmanage storageattach BrianOS --storagectl IDE --port 0 --device 0 --medium boot_drive.vdi --type hdd
pause
exit

no_argument:
echo Invalid argument or no argument specified. Exiting.
pause