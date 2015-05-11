#!/bin/bash
MINOR=`sw_vers -productVersion | cut -d "." -f 2`
User=`logname`

#Install LaunchD 'watchfile' to watch Manifest.plist for changes.

if [ $MINOR = "6" ]
  then
  #10.6
  Manifest="/Users/$User/Library/Application Support/AppStore/manifest.plist"
else

  #10.7/8/9/10
  Manifest=`find /var/folders -name manifest.plist 2>/dev/null | grep "/C/com.apple.appstore"`
fi


/usr/libexec/PlistBuddy -c "Add :Label string com.watch.manifest.appstore.apple" /Users/$User/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
/usr/libexec/PlistBuddy -c "Add :ProgramArguments array" /Users/$User/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
#test #/usr/libexec/PlistBuddy -c "Add :ProgramArguments:Item\ 0 string 'say lol'" /Users/$User/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
/usr/libexec/PlistBuddy -c "Add :ProgramArguments:Item\ 0 string '/Users/$User/.repkg.sh'" /Users/$User/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
/usr/libexec/PlistBuddy -c "Add :WatchPaths array '$Manifest'" /Users/$User/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
/usr/libexec/PlistBuddy -c "Add :WatchPaths:Item\ 0 string '$Manifest'" /Users/$User/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
cd "$(dirname "$0")"
cp ./repkg.sh /Users/$User/.repkg.sh
launchctl load -w /Users/$User/Library/LaunchAgents/com.watch.manifest.appstore.apple.plist
