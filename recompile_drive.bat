@echo off
if exist boot_drive.vdi del /F boot_drive.vdi
nasm boot_sector.asm -f bin -o boot_sector.bin
VBoxManage convertdd boot_sector.bin boot_drive.vdi --format VDI
pause