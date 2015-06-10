#!/bin/bash
#say lol
MINOR=`sw_vers -productVersion | cut -d "." -f 2`
if [ $MINOR = "6" ]
  then
  #10.6
  User=`logname`
  Manifest="/Users/$User/Library/Application Support/AppStore/manifest.plist"
  Cache="/Users/$User/Library/Application Support/AppStore"
  mkdir "/Users/$User/appstorerepkg"
  #open /Users/$User/appstorerepkg
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
         if [ "$SubTitle" = "Apple" ]
          then
      echo $BundleID > /Users/$User/appstorerepkg/$BundleID.txt
      echo $Title >> /Users/$User/appstorerepkg/$BundleID.txt
      echo $SubTitle >> /Users/$User/appstorerepkg/$BundleID.txt
      echo $PKG >> /Users/$User/appstorerepkg/$BundleID.txt
      echo $Size >> /Users/$User/appstorerepkg/$BundleID.txt
      echo $ItemID >> /Users/$User/appstorerepkg/$BundleID.txt
      ln "$Cache/$ItemID/$PKG" /Users/$User/appstorerepkg/$BundleID.pkg
        else
          echo "$Title is not an Apple pkg so will not redistribute"
        fi
      let itemNumber=itemNumber+1 
      
    done

else

  #10.7/8/9/10
  User=`logname`
  Manifest=`find /var/folders -name manifest.plist 2>/dev/null | grep "/C/com.apple.appstore"`
  Cache=`echo "${Manifest%/*}"/`
  mkdir "/Users/$User/appstorerepkg"
  #open /Users/$User/appstorerepkg

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
        if [ "$SubTitle" = "Apple" ]
          then
      echo $BundleID > /Users/$User/appstorerepkg/$BundleID.$BundleVer.txt
      echo $BundleVer >> /Users/$User/appstorerepkg/$BundleID.$BundleVer.txt
      echo $Title >> /Users/$User/appstorerepkg/$BundleID.$BundleVer.txt
      echo $SubTitle >> /Users/$User/appstorerepkg/appstorerepkg/$BundleID.$BundleVer.txt
      echo $PKG >> /Users/$User/appstorerepkg/$BundleID.$BundleVer.txt
      echo $Size >> /Users/$User/appstorerepkg/$BundleID.$BundleVer.txt
      echo $ItemID >> /Users/$User/appstorerepkg/$BundleID.$BundleVer.txt
      ln $Cache/$ItemID/$PKG /Users/$User/appstorerepkg/$BundleID.$BundleVer.pkg
        else
          echo "$Title is not an Apple pkg so will not redistribute"
        fi
      let itemNumber=itemNumber+1 
    done

fi
exit 0
