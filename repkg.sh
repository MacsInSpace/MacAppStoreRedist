#!/bin/bash
MINOR=`sw_vers -productVersion | cut -d "." -f 2`
if [ $MINOR = "6" ]
  then
  #10.6
  User=`whoami`
  Manifest="/Users/$User/Library/Application Support/AppStore/manifest.plist"
  Cache="/Users/$User/Library/Application Support/AppStore"
  mkdir /tmp/appstorerepkg
  itemNumber=0

    while [ $itemNumber -lt 100 ]; do

      BundleID=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:bundle-id" "$Manifest"`
        if [ "$BundleID" = "" ]
          then
          break
        fi
      Title=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:title" "$Manifest"`
      SubTitle=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:subtitle" "$Manifest"`
      PKG=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:assets:0:name" "$Manifest"`
      Size=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:assets:0:size" "$Manifest"`
      ItemID=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:item-id" "$Manifest"`

      echo $BundleID > /tmp/appstorerepkg/$BundleID.txt
      echo $Title >> /tmp/appstorerepkg/$BundleID.txt
      echo $SubTitle >> /tmp/appstorerepkg/$BundleID.txt
      echo $PKG >> /tmp/appstorerepkg/$BundleID.txt
      echo $Size >> /tmp/appstorerepkg/$BundleID.txt
      echo $ItemID >> /tmp/appstorerepkg/$BundleID.txt

      let itemNumber=itemNumber+1 
      ln "$Cache/$ItemID/$PKG" /tmp/appstorerepkg/$BundleID.pkg
      
    done

else

  #10.7/8/9/10
  Manifest=`find /var/folders -name manifest.plist 2>/dev/null | grep "/C/com.apple.appstore"`
  Cache=`echo "${Manifest%/*}"/`
  mkdir /tmp/appstorerepkg
  itemNumber=0

    while [ $itemNumber -lt 100 ]; do

      BundleID=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:bundle-id" $Manifest`
        if [ "$BundleID" = "" ]
          then
          break
        fi
      Title=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:title" $Manifest`
      SubTitle=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:subtitle" $Manifest`
      PKG=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:assets:0:name" $Manifest`
      Size=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:assets:0:size" $Manifest`
      ItemID=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:item-id" $Manifest`
      BundleVer=`/usr/libexec/PlistBuddy -c "print :representations:$itemNumber:bundle-version" $Manifest`

      echo $BundleID > /tmp/appstorerepkg/$BundleID.$BundleVer.txt
      echo $BundleVer >> /tmp/appstorerepkg/$BundleID.$BundleVer.txt
      echo $Title >> /tmp/appstorerepkg/$BundleID.$BundleVer.txt
      echo $SubTitle >> /tmp/appstorerepkg/$BundleID.$BundleVer.txt
      echo $PKG >> /tmp/appstorerepkg/$BundleID.$BundleVer.txt
      echo $Size >> /tmp/appstorerepkg/$BundleID.$BundleVer.txt
      echo $ItemID >> /tmp/appstorerepkg/$BundleID.$BundleVer.txt

      let itemNumber=itemNumber+1 
      ln $Cache/$ItemID/$PKG /tmp/appstorerepkg/$BundleID.$BundleVer.pkg
    done

fi
exit 0
