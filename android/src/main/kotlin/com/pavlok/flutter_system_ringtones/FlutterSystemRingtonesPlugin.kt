package com.pavlok.flutter_system_ringtones

import android.content.Context
import android.database.CrossProcessCursor
import android.database.Cursor
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

    private var ringtones = arrayListOf<HashMap<String, Any>>()
    private var alarms = arrayListOf<HashMap<String, Any>>()
    private var notifications = arrayListOf<HashMap<String, Any>>()




    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_system_ringtones")
        channel.setMethodCallHandler(this)
        loadRingtones(flutterPluginBinding.applicationContext)
        loadAlarms(flutterPluginBinding.applicationContext)
        loadNotifications(flutterPluginBinding.applicationContext)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getRingtones") {
            result.success(ringtones);
            return
        }
        if (call.method == "getNotifications") {
            result.success(notifications);
            return
        }
        if (call.method == "getAlarms") {
            result.success(alarms);
            return
        }
            result.notImplemented()

    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        clear()
        channel.setMethodCallHandler(null)
    }

   private fun loadRingtones(context: Context) {
      val ringtoneManager = RingtoneManager(context)
       ringtoneManager.setType(RingtoneManager.TYPE_RINGTONE);
       val cursor = ringtoneManager.cursor
       load(cursor, ringtones)

    }
    private fun loadAlarms(context: Context) {
        val ringtoneManager = RingtoneManager(context)
        ringtoneManager.setType(RingtoneManager.TYPE_ALARM);
        val cursor = ringtoneManager.cursor
        load(cursor, alarms)
    }
    private fun loadNotifications(context: Context) {
        val ringtoneManager = RingtoneManager(context)
        ringtoneManager.setType(RingtoneManager.TYPE_NOTIFICATION);
        val cursor = ringtoneManager.cursor
        load(cursor, notifications)
    }

    private fun load(cursor: Cursor,  list: ArrayList<HashMap<String, Any>>){
        if (!cursor.isFirst) cursor.moveToFirst()
        do {

            val itemTitle = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX)
            val itemId = cursor.getString(RingtoneManager.ID_COLUMN_INDEX)
            val itemUri =
                cursor.getString(RingtoneManager.URI_COLUMN_INDEX) + "/" + itemId
            val temp = hashMapOf<String, Any>(
                "id" to itemId,
                "title" to itemTitle,
                "uri" to itemUri,
            )
            list.add(temp)
        } while (cursor.moveToNext())
        cursor.close()

    }


   private fun clear() {
       ringtones.clear()
       alarms.clear()
       notifications.clear()

    }

}
