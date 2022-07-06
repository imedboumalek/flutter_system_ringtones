package com.pavlok.flutter_system_ringtones

import android.content.Context
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
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
     private var ringtones = arrayListOf<HashMap<String, Any>>()


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        loadRingtones(flutterPluginBinding.applicationContext)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_system_ringtones")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getRingtones") {
            result.success(ringtones);
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
       ringtoneManager.setType(RingtoneManager.TYPE_RINGTONE);
       val cursor = ringtoneManager.cursor
       if (!cursor.isFirst) cursor.moveToFirst()
       do {

           val notificationTitle = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX)
           val notificationId = cursor.getString(RingtoneManager.ID_COLUMN_INDEX)
           val notificationUri =
               cursor.getString(RingtoneManager.URI_COLUMN_INDEX) + "/" + notificationId
           val temp = hashMapOf<String, Any>(
               "id" to notificationId,
               "title" to notificationTitle,
               "uri" to notificationUri,
           )
           ringtones.add(temp)
           println(temp)

       } while (cursor.moveToNext())
        cursor.close()
    }


   private fun emptyRingtones() {
        ringtones.clear()
    }
}
