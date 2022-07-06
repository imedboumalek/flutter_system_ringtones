package com.pavlok.flutter_system_ringtones

import android.content.Context
import android.media.Ringtone
import android.media.RingtoneManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterSystemRingtonesPlugin */
class FlutterSystemRingtonesPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var ringtoneManager: RingtoneManager
     private var ringtones = arrayListOf<Ringtone>()


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        loadRingtones(flutterPluginBinding.applicationContext)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_system_ringtones")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        emptyRingtones()
        channel.setMethodCallHandler(null)
    }

   private fun loadRingtones(context: Context) {
        ringtoneManager = RingtoneManager(context)
        if (!ringtoneManager.cursor.isFirst) ringtoneManager.cursor.moveToFirst()
        do {
            val temp = ringtoneManager.getRingtone(ringtoneManager.cursor.position)
            ringtones.add(temp)

            println(temp.getTitle(context))
        } while (ringtoneManager.cursor.moveToNext())
        ringtoneManager.cursor.close()
    }


   private fun emptyRingtones() {
        ringtones.clear()
    }
}
