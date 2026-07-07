package dev.imed.flutter_system_ringtones

import android.content.Context
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

/** FlutterSystemRingtonesPlugin */
class FlutterSystemRingtonesPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    private val executor: ExecutorService = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())

    // Lists are loaded lazily on first request and cached for the engine's lifetime.
    private val cache = HashMap<Int, List<HashMap<String, Any>>>()

    private var currentRingtone: Ringtone? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_system_ringtones")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getRingtones" -> getSounds(RingtoneManager.TYPE_RINGTONE, result)
            "getAlarms" -> getSounds(RingtoneManager.TYPE_ALARM, result)
            "getNotifications" -> getSounds(RingtoneManager.TYPE_NOTIFICATION, result)
            "play" -> play(call, result)
            "stop" -> {
                stopPlayback()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        stopPlayback()
        executor.shutdown()
        cache.clear()
        channel.setMethodCallHandler(null)
    }

    private fun getSounds(type: Int, result: Result) {
        cache[type]?.let {
            result.success(it)
            return
        }
        executor.execute {
            try {
                val sounds = loadSounds(type)
                mainHandler.post {
                    cache[type] = sounds
                    result.success(sounds)
                }
            } catch (e: Exception) {
                mainHandler.post {
                    result.error("LOAD_ERROR", e.message, null)
                }
            }
        }
    }

    private fun loadSounds(type: Int): List<HashMap<String, Any>> {
        val ringtoneManager = RingtoneManager(context)
        ringtoneManager.setType(type)
        val cursor = ringtoneManager.cursor
        val sounds = arrayListOf<HashMap<String, Any>>()
        // RingtoneManager owns the cursor; do not close it here.
        if (!cursor.moveToFirst()) return sounds
        do {
            val id = cursor.getString(RingtoneManager.ID_COLUMN_INDEX) ?: continue
            val title = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX) ?: id
            val uri = ringtoneManager.getRingtoneUri(cursor.position)?.toString() ?: continue
            sounds.add(
                hashMapOf(
                    "id" to id,
                    "title" to title,
                    "uri" to uri,
                )
            )
        } while (cursor.moveToNext())
        return sounds
    }

    private fun play(call: MethodCall, result: Result) {
        val uri = call.argument<String>("uri")
        if (uri.isNullOrBlank()) {
            result.error("INVALID_ARGUMENT", "Missing or empty 'uri' argument", null)
            return
        }
        try {
            stopPlayback()
            val ringtone = RingtoneManager.getRingtone(context, Uri.parse(uri))
            if (ringtone == null) {
                result.error("PLAY_ERROR", "Could not resolve ringtone for uri: $uri", null)
                return
            }
            currentRingtone = ringtone
            ringtone.play()
            result.success(null)
        } catch (e: Exception) {
            result.error("PLAY_ERROR", e.message, null)
        }
    }

    private fun stopPlayback() {
        currentRingtone?.stop()
        currentRingtone = null
    }
}
