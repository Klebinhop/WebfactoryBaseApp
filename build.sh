# $1 for ip
# $2 for port
# $3 for pairing code
# $4 for adress
# $5 for other ip
export ANDROID_HOME="/data/data/com.termux/files/usr/share/android-sdk/"
echo "$2 $1"
7zz x wwwfactory.7z
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

echo "# Specifies the JVM arguments used for the daemon process.
# The setting is particularly useful for tweaking memory settings.
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
# When configured, Gradle will run in incubating parallel mode.
# This option should only be used with decoupled projects. More details, visit
# http://www.gradle.org/docs/current/userguide/multi_project_builds.html#sec:decoupled_projects
# org.gradle.parallel=true
# AndroidX package structure to make it clearer which packages are bundled with the
# Android operating system, and which are packaged with your app's APK
# https://developer.android.com/topic/libraries/support-library/androidx-rn
android.useAndroidX=true
# Kotlin code style for this project: 'official' or 'obsolete':
kotlin.code.style=official
# Enables namespacing of each library's R class so that its R class includes only the
# resources declared in the library itself and none from the library's dependencies,
# thereby reducing the size of the R class for that library
android.nonTransitiveRClass=true
android.aapt2FromMavenOverride=$(which aapt2)" > gradle.properties

sudo setprop service.adb.tcp.port "5555"
sudo stop adbd
sudo start adbd
adb connect localhost
./gradlew build
./gradlew installDebug
