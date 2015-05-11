#!/bin/bash
MINOR=`sw_vers -productVersion | cut -d "." -f 2`
User=`logname`

#Install LaunchD 'watchfile' to watch Manifest.plist for changes.
touch ~/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist

if [ $MINOR = "6" ]
  then
  #10.6
  Manifest="/Users/$User/Library/Application Support/AppStore/manifest.plist"
else

  #10.7/8/9/10
  Manifest=`find /var/folders -name manifest.plist 2>/dev/null | grep "/C/com.apple.appstore"`
fi


/usr/libexec/PlistBuddy -c "Add :Label string watchManifest" ~/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
/usr/libexec/PlistBuddy -c "Add :ProgramArguments array" ~/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
#test #/usr/libexec/PlistBuddy -c "Add :ProgramArguments:Item\ 0 string 'say lol'" ~/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
/usr/libexec/PlistBuddy -c "Add :ProgramArguments:Item\ 0 string '~/.repkg.sh'" ~/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
/usr/libexec/PlistBuddy -c "Add :WatchPaths array '$Manifest'" ~/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
/usr/libexec/PlistBuddy -c "Add :WatchPaths:Item\ 0 string '$Manifest'" ~/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
cp ./repkg.sh ~/.repkg.sh
launchctl load -w ~/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
