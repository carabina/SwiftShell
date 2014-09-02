#!/bin/bash

#
# SwiftShell run script
#

# The folders where Swift can find the frameworks it imports as modules.
# SwiftShell.framework must be in one of these.
FRAMEWORKS_PATH=$DYLD_FRAMEWORK_PATH:~/Library/Frameworks:/Library/Frameworks

# Add a : to the beginning if not already there
if [[ $FRAMEWORKS_PATH != :* ]] 
then
	FRAMEWORKS_PATH=:$FRAMEWORKS_PATH
fi

# Swift needs folders one at a time, so we replace : with " -F "
SWIFT_FRAMEWORK_ARGUMENTS=${FRAMEWORKS_PATH//:/ -F }

#export SDKROOT=/Applications/Xcode6-Beta6.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk

# Pass Swift all the arguments, the first of which is the Swift file to run.
xcrun swift -sdk /Applications/Xcode6-Beta6.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk  -F $(xcrun --show-sdk-path --sdk macosx)/System/Library/Frameworks $SWIFT_FRAMEWORK_ARGUMENTS "$@"
#echo xcrun swift -F $(xcrun --show-sdk-path --sdk macosx)/System/Library/Frameworks $SWIFT_FRAMEWORK_ARGUMENTS "$@"
#-sdk $(xcrun --show-sdk-path --sdk macosx)
