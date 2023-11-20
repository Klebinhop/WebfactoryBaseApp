# $1 for ip
# $2 for port
# $3 for pairing code
# $4 for adress
export ANDROID_HOME="/data/data/com.termux/files/usr/share/android-sdk/"
7z x Arquivo.7z
cd wwwfactory
echo "<resources>
    <string name='app_name'>wwwfactory</string>
    <string name='Web_Adress'>$4</string>
</resources>" > app/src/main/res/values/strings.xml
echo "## This file is automatically generated by Android Studio.
# Do not modify this file -- YOUR CHANGES WILL BE ERASED!
#
# This file should *NOT* be checked into Version Control Systems,
# as it contains information specific to your local configuration.
#
# Location of the SDK. This is only used by Gradle.
# For customization when using a Version Control System, please read the
# header note.
sdk.dir=$ANDROID_HOME" > local.properties
adb pair "$1:$2 $3"
./gradlew build
./gradlew installDebug
