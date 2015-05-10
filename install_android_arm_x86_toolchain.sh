#!/bin/bash
#
# NOTE: NEED TO INSTALL NDK toolset from
#
NDK_ANDROID_VERSION=android-ndk-r10d
NDK_ANDROID_ARM_X86_PACKAGE=$NDK_ANDROID_VERSION-linux-x86.bin
NDK_PATH=~/.ndk
#check wget command exist.
if ! type "wget" > /dev/null; then
        echo "[wget] are not installed."
        exit 1
fi

echo "*****  SET NDK PATH=$NDK_PATH   *****"
#make and go NDK directory
mkdir -p $NDK_PATH && cd $NDK_PATH

#get NDK ARM_X86
wget -O $NDK_ANDROID_ARM_X86_PACKAGE http://dl.google.com/android/ndk/$NDK_ANDROID_X86_PACKAGE
chmod 755 $NDK_ANDROID_ARM_X86_PACKAGE

#extract NDK package.
./$NDK_ANDROID_ARM_X86_PACKAGE

#link toolchain.
echo "======================"
echo "| link NDK toolchain |"
echo "======================"
mkdir -p ~/bin
mkdir -p ~/bin/$NDK_ANDROID_VERSION
ln -s $PWD/$NDK_ANDROID_VERSION/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-* ~/bin/$NDK_ANDROID_VERSION

echo "======================"
echo "|  SET NDK toolchain |"
echo "======================"
#set enviroment.
echo "#======================" >> ~/.bashrc
echo "#|    NDK toolchain   |" >> ~/.bashrc
echo "#======================" >> ~/.bashrc
echo "export NDK_PATH=$NDK_PATH" >> ~/.bashrc
echo "export NDK_ANDROID_VERSION=$NDK_ANDROID_VERSION" >> ~/.bashrc
echo "export NDK=\$NDK_PATH/\$NDK_ANDROID_VERSION" >> ~/.bashrc
echo "export NDK_TOOLCHAIN=\$NDK_PATH/\$NDK_ANDROID_VERSION/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-" >> ~/.bashrc
echo "export NDK_SYSROOT=\$NDK/platforms/android-21/arch-arm" >> ~/.bashrc
echo "export PATH=\"/home/\$USER/bin/\$NDK_ANDROID_VERSION:\$PATH\"" >> ~/.bashrc
echo "export PATH=\$(echo \$PATH | sed 's/:/\\n/g' | sort | uniq | tr -s '\\n' ':' | sed 's/:\$//g')" >> ~/.bashrc

#finish.
echo "========"
echo "| done |"
echo "========"
echo "You can use arm-linux-androideabi-gcc --sysroot=\${NDK_SYSROOT} -o [output-binary-name] [input-file-name]"
exec bash
