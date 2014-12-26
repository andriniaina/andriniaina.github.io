---
layout: post
categories: EN tooling.
title: How to clone Windows to a new drive/partition
---

I just bought a new SSD to replace my old HDD. I did not want to reinstall Windows because I did not want to lose all my settings and apps.

Some [guides](http://lifehacker.com/5837543/how-to-migrate-to-a-solid-state-drive-without-reinstalling-windows) are available but none was completely satisfying. I tried to clone my drive using [EaseUS ToDo Backup Free Tools](http://www.easeus.com/backup-software/tb-free.html) but the process seemed to be stuck at some point, occupying 100% of my CPU. I would later learn that it cannot clone a drive with defective sectors. Also, the software is apparently throttled in order to encourage people to buy the faster non-free version.

So, I just spent 2 days reading blogs, forum posts, technet articles, cloning/copying/repairing my system. 
Here are the steps if you want to do the same things as me.


1. Using [Unetbootin](http://unetbootin.sourceforge.net/), install [CloneZilla Live](http://clonezilla.org/) on the same bootable drive as Windows.
2. Reboot and clone the drive to the new SSD (see tutorials [here](http://www.bing.com/search?q=clonezilla+tutorial&setmkt=en-US))
    * If you have bad sectors like me, you **must** use the expert mode and select the `rescue` option
    * You can select multiple partitions
    * If you are copying from one drive to another, chances are that both drives do not have the same sizes. In this case, select the `-k1` option. For some reason, this did not work for me (see below for fix). Note that this option is not in the same dialog as the `rescue` option. 

Now the hard part: In my case, Clonezilla correctly cloned the partition but I did not clone the 100MB system partition (this partition is automatically created by Win8 and contains the boot files). Actually I was not even aware that an Win8 installation requires a separate 100MB system partition... Also, Clonezilla *cloned* my drive, meaning that it created a 70Gb partition that somehow occupies the whole capacity of the new drive...

3. Resize the cloned partition, using the **old** Windows installation. This step cannot be done with the disk tools from Microsoft. Windows will think that the new partition fully occupies the drive. I used [EaseUS Partition Manager Free](http://www.easeus.com/partition-manager/epm-free.html). I had to shrink the partition first and then re-expand it.
4. Now that you have more space on the new drive, create the system boot partition
    * Still in EaseUS, create an empty partition of 100MB
5. Clone the old system partition to the new partition
6. Mount both drives (the new system partition and the new windows partition) respectively in `X:` and `Z:`
7. Edit the BCD (Boot Configuration Data) using [Visual BCD editor](http://www.boyans.net/DownloadVisualBCD.html)
    * create a new OS entry, by copying the old loader information (you can use `bcdedit /copy {current} /d xxxxxx` in command line).
    * adapt the new entry: make it point to the new Windows partition (`Z:`). You need to change both the `ApplicationDevice` and `OSDevice` properties
    * copy the boot records to the new drive: in the menu, select *Repair > Repair boot records* and *Repair > Repair bcd*, each time selecting `X:` as the system partition and `z:\Windows` as the Windows installation folder.
8. Reboot, select the new Windows, log in

At this point, everything is probably fucked up because Windows does not care if you cloned the drive; Windows only uses the device ids and still recognizes the old drive as `C:`, which would be great... in other circumstances. The system boots but reads system files from `C:` (the old drive) and everything point to `C:`. 

8. Now reboot in the **old** Windows again (The point of the previous step was just to create the correct drive ids in the registry)
9. Reassign drive letters (you can't do this directly in the new Windows installation; you can't reassign the drive letter of the running windows partition):
    * Open `regedit`
    * select the root node `HKEY_LOCAL_MACHINE`
    * open the registry of the new Windows: select the menu *File > Load hive...*, open the hive `Z:\Windows\System32\config\SYSTEM`, give it a key name of you choice
    * you need to edit keys in `HKLM\SYSTEM\MountedDevices`; Delete the key `\DosDevices\C:`, rename `\DosDevices\L:` to `\DosDevices\C:` (where L: is the letter that windows automatically assigned to the new drive)
10. Reboot in the **new** Windows
11. Enjoy


> **Conclusion**: You've made it to here and survived :)  but you probably realize now that it was not worth it. It's just faster and easier to start with a fresh Windows installation...

