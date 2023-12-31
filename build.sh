# $1 for Web Adress
# $2 for Site Name

pkg install wget aapt2 android-tools 7zip tsu graphicsmagick which openjdk-17 -y

wget https://github.com/Lzhiyong/termux-ndk/releases/download/android-sdk/android-sdk-aarch64.zip
unzip android-sdk-aarch64.zip -d $PREFIX/share
echo '#!/data/data/com.termux/files/usr/bin/bash

/data/data/com.termux/files/usr/share/android-sdk/tools/bin/sdkmanager \
--sdk_root=/data/data/com.termux/files/usr/share/android-sdk "$@"' > $PREFIX/bin/sdkmanager

export ANDROID_HOME="/data/data/com.termux/files/usr/share/android-sdk/"
7zz x wwwfactory.7z
cd wwwfactory

echo "<resources>
    <string name='app_name'>$2</string>
    <string name='Web_Adress'>$1</string>
</resources>" > app/src/main/res/values/strings.xml

echo "## This file is automatically generated by Android Studio.
# Do not modify this file -- YOUR CHANGES WILL BE ERASED!
#
# This file should *NOT* be checked into Version Control Systems,
# as it contains information specific to your local configuration.
#
# Location of the SDK. This is only used by Gradle.
# For customization when using a Version Control System, please read theteste
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
# resources declared in the library itself and none from the library's dependencies,round
# thereby reducing the size of the R class for that library
android.nonTransitiveRClass=true
android.aapt2FromMavenOverride=$(which aapt2)" > gradle.properties

echo "plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
}

android {
    namespace 'com.wwwfactory'
    compileSdk 33

    defaultConfig {
        applicationId 'com.$2.webfactory'
        minSdk 29
        targetSdk 33
        versionCode 1
        versionName '1.0'

        testInstrumentationRunner 'androidx.test.runner.AndroidJUnitRunner'
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = '1.8'
    }
}

dependencies {
    implementation 'androidx.core:core-ktx:1.8.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.5.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
    testImplementation 'junit:junit:4.13.2'
    androidTestImplementation 'androidx.test.ext:junit:1.1.5'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.5.1'
    implementation 'androidx.browser:browser:1.3.0'
}" > app/build.gradle

sed -i 1d gradlew

sudo setprop service.adb.tcp.port "5555"
sudo stop adbd
sudo start adbd
adb connect localhost
./gradlew build
./gradlew installDebug
rm -rf WebFactoryBaseApp*
