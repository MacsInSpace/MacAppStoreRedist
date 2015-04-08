# MacAppStoreRedist
Script to parse the Mac App Store Manifest.plist and hard link and rename any current downloads from the Mac App Store for redist.

This shell script searches for the Mac App Store folder and creates hard links to any pkg and also creates a matching text file with details of the pkg.

I'm hoping to automate this process via a launchd "watch" process that watches the AppStores manifest.plist for changes and then kicks off the script.

I'd like to eventually have it wait until the size of the pkg is correct (downloaded) and then work on the pkg and flatten it/repackage it if needed.

It creates and saves to "/tmp/appstorerepkg" for now to be worked on so will be deleted upon reboot. 
No need for sudo.
