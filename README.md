BrianOS
=======
BrianOS is an open source operating system I am creating to learn the fundamentals of OS development.

Usage
-----
Three scripts are provided for compiling and running boot sectors:
 - recompile_drive.bat: recompile the drive and output build information
 - recompile_run_drive.bat: recompile and run the drive without outputting build information
 - run_drive.bat: run the virtual machine with whichever drive is currently set.  Doesn't take a command-line parameter

Three things are assumed for these scripts to correctly execute:
 - NASM and VirtualBox are installed
 - The paths to both executables are included in the PATH anvironment variable
 - There is a virtual machine named "BrianOS" created in VirtualBox.  This VM should have an operating system of "Other/Unknown"

Unless it explicitly says so above, the scripts take a command-line parameter consisting of the file location (relative to the CWD or absolute) of a boot sector assembly file. You can either drag an assembly file into them or you can call the scripts with a parameter from command prompt.

References
----------
The following references have been invaluable to me in creating the code I have so far:
http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
http://askubuntu.com/questions/34802/convert-my-physical-operating-system-to-a-virtualbox-disk
http://gerardnico.com/wiki/virtualbox/hard_disk_inaccessible
https://www.virtualbox.org/manual/ch08.html
http://www.virtualbox.org/manual/ch12.html#ts_debugger
http://fisnikhasani.com/building-your-own-bootloader/