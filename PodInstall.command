#!/bin/sh
rm -rf ~/Library/Developer/Xcode/DerivedData
cd "$(dirname "$0")"
pod install --repo-update
