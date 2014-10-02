BrianOS
=======
BrianOS is an open source operating system I am creating to learn the fundamentals of OS development.

Usage
-----
In order to run an example sector, it will need to be moved from /example_sectors to the parent directory and renamed "boot_sector.asm".
After that, to compile the boot sector, run "recompile_drive.bat".  To run the boot sector in a virtual machine (and to forego any build output), run "recompile_run_drive.bat".  Both of these scripts assume three things:
 - NASM and VirtualBox are installed
 - The paths to both executables are included in the PATH anvironment variable
 - There is a virtual machine named "BrianOS" created in VirtualBox.  This VM should have an operating system of "Other/Unknown"

References
----------
The following references have been invaluable to me in creating the code I have so far:
http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
http://askubuntu.com/questions/34802/convert-my-physical-operating-system-to-a-virtualbox-disk
http://gerardnico.com/wiki/virtualbox/hard_disk_inaccessible
https://www.virtualbox.org/manual/ch08.html
