# MacAppStoreRedist
This is a LaunchD process to watch the Mac App Store Manifest.plist and hard link and rename any current Apple downloads from the Mac App Store for redistribution. Maybe later for Munki or Casper import.

LaunchD runs a shell script which searches for the Mac App Store folder and creates hard links to any pkg and also creates a matching text file with details of the pkg.

To install, unzip and run the ServiceInstall.sh.
*note that it must have the repkg.sh in the same dir.


I'd like to eventually have it wait until the size of the pkg is correct (downloaded) and then work on the pkg and flatten it/repackage it if needed.

It creates and saves to "~/appstorerepkg" for now. 
No need for sudo.

![alt tag](http://i.imgur.com/DgxvpQk.png)

References:

https://derflounder.wordpress.com/2013/08/22/downloading-apples-server-app-installer-package/
https://jamfnation.jamfsoftware.com/discussion.html?id=5591

May need to add this to the end of the script once filesize = 100% downloaded:
pkgutil --expand mzm.exgoawfi.pkg appstore.pkg 
pkgutil --flatten appstore.pkg/whatever.pkg whatever.pkg 
ref:https://jamfnation.jamfsoftware.com/discussion.html?id=5591

Also:
https://groups.google.com/forum/#!topic/munki-dev/XvrAXe7J5oE
https://groups.google.com/forum/#!msg/munki-dev/XvrAXe7J5oE/vm4s3Xd0Qw4J
https://groups.google.com/forum/#!searchin/macenterprise/appstore/macenterprise/Vs3sAalXNzI/mIUN-GtJMc8J
https://groups.google.com/forum/#!searchin/macenterprise/appstore/macenterprise/nbL6HrMRG-0/m9pzYYxYb1UJ
https://groups.google.com/forum/#!searchin/macenterprise/appstore/macenterprise/Y9cej17S_ag/mFqLWni33JYJ
