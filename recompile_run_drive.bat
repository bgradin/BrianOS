@echo off
if "%1"=="" goto no_argument

cd %~dp1 >nul 2>&1
if not exist bin\NUL mkdir bin >nul 2>&1

nasm %~nx1 -f bin -o bin\boot_sector.bin >nul 2>&1

cd bin >nul 2>&1
if exist boot_drive.vdi del /F boot_drive.vdi >nul 2>&1
vboxmanage convertdd boot_sector.bin boot_drive.vdi --format VDI >nul 2>&1
vboxmanage storageattach BrianOS --storagectl IDE --port 0 --device 0 --medium none >nul 2>&1
vboxmanage closemedium disk boot_drive.vdi >nul 2>&1
vboxmanage storageattach BrianOS --storagectl IDE --port 0 --device 0 --medium boot_drive.vdi --type hdd >nul 2>&1
vboxmanage startvm BrianOS >nul 2>&1
exit

no_argument:
echo No argument specified. Exiting.
pause