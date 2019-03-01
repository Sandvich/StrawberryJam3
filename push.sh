#!/usr/bin/env bash
# Edit variables below to change your settings.
# Remember that you need a file called buildnumber in your build directory, with a single number inside in the form x.y.z

# The directory where your source is saved
SOURCE_DIR=$(pwd)"/src"

# The directory to which you  want to export your project. You should have osx, linux and windows executables under this directory, each containing the relevant build (assets exported as data.pck)
BUILD_DIR=$(pwd)

# The name of the 'main' file for the project. Eg. if the project produces files called FursonaCreator.app, FursonaCreator.exe and FursonaCreator.x86_64, this should be set to FursonaCreator
FILENAME="WetRave"

# The name of your itch.io page, in butler terms. For example, fursona creator is on ttio.itch.io/fursona-creator, so the page name in butler terms is ttio/fursona-creator.
PROJECT="ttio/wet-rave"

cd $SOURCE_DIR
godot --export "Linux/X11" $BUILD_DIR"/linux/"$FILENAME".x86_64"
godot --export "Mac OSX" $BUILD_DIR"/osx/"$FILENAME".zip"
godot --export "Windows Desktop" $BUILD_DIR"/windows/"$FILENAME".exe"

cd $BUILD_DIR
echo "Previous build number is "$(cat buildnumber)
echo "Please enter the build number, followed by the return key:"
read BUILD_NUM
echo $BUILD_NUM > buildnumber

echo "Set Linux to executable"
chmod +x linux/$FILENAME.x86_64

echo "Unpack OS X"
unzip osx/$FILENAME.zip -d osx
rm osx/$FILENAME.zip

echo "Ready to upload. Press any key to continue."
read -n 1

butler push linux $PROJECT:linux-64 --userversion-file buildnumber
butler push osx $PROJECT:osx-universal --userversion-file buildnumber
butler push windows $PROJECT:windows-64 --userversion-file buildnumber

echo "Build files will now be deleted. Press any key to continue."
read -n 1

rm -rf osx/*
rm -rf linux/*
rm -rf windows/*
