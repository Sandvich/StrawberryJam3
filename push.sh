#!/usr/bin/env bash
# Edit variables below to change your settings.
# Remember that you need a file called buildnumber in your build directory, with a single number inside in the form x.y.z

# The directory to which you export your project. You should have osx, linux and windows folders under this directory, each containing the relevant build (assets exported as data.zip)
BUILD_DIR=.

# The name of the 'main' file for the project. Eg. if the project produces files called FursonaCreator.app, FursonaCreator.exe and FursonaCreator.x86_64, this should be set to FursonaCreator
FILENAME="WetRave"

# The name of your itch.io page, in butler terms. For example, fursona creator is on ttio.itch.io/fursona-creator, so the page name in butler terms is ttio/fursona-creator.
PROJECT="ttio/wet-rave"

cd $BUILD_DIR

echo "Move executables to their directories"
mv $FILENAME.x86_64 linux/
cp $FILENAME.pck linux/
mv $FILENAME.zip osx/
cp $FILENAME.pck osx/
mv $FILENAME.exe windows/
mv $FILENAME.pck windows/

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
