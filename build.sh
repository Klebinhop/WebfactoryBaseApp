# $1 for ip
# $2 for port
# $3 for pairing code
# $4 for adress
export ANDROID_HOME="../../usr/share/android-sdk/"
unzip wwwfactory.zip
cd wwwfactory
echo "package com.wwwfactory

import android.net.Uri
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.browser.customtabs.CustomTabsIntent
import kotlin.system.exitProcess

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val builder = CustomTabsIntent.Builder()
        builder.setInstantAppsEnabled(true)
        val customBuilder = builder.build()
        customBuilder.intent.setPackage('com.android.chrome')
        customBuilder.launchUrl(this, Uri.parse('$4'))
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        finishAndRemoveTask();
    }

}" > app/src/main/java/com/wwwfactory/MainActivity.kt
adb pair "$1:$2 $3"
./gradlew build
./gradlew installDebug
