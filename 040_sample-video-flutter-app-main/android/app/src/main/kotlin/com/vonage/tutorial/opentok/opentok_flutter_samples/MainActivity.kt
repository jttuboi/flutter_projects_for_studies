package com.vonage.tutorial.opentok.opentok_flutter_samples

import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.vonage.tutorial.opentok.opentok_flutter_samples.config.SdkState
import com.vonage.tutorial.opentok.opentok_flutter_samples.one_to_one_video.OneToOneVideo
import com.vonage.tutorial.opentok.opentok_flutter_samples.one_to_one_video.OpentokVideoFactory
import io.flutter.plugin.common.BinaryMessenger

class MainActivity : FlutterActivity() {

    val oneToOneVideoMethodChannel = "com.vonage.one_to_one_video"

    private var oneToOneVideo: OneToOneVideo? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        oneToOneVideo = OneToOneVideo(this)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("opentok-video-container", OpentokVideoFactory())

        addFlutterChannelListener()
    }

    private fun addFlutterChannelListener() {
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            setOneToOneVideoMethodChannel(it)
        }
    }

    private fun setOneToOneVideoMethodChannel(it: BinaryMessenger) {
        MethodChannel(it, oneToOneVideoMethodChannel).setMethodCallHandler { call, result ->

            when (call.method) {
                "initSession" -> {
                    val apiKey = requireNotNull(call.argument<String>("apiKey"))
                    val sessionId = requireNotNull(call.argument<String>("sessionId"))
                    val token = requireNotNull(call.argument<String>("token"))

                    updateFlutterState(SdkState.wait, oneToOneVideoMethodChannel)
                    oneToOneVideo?.initSession(apiKey, sessionId, token)
                    result.success("")
                }
                "swapCamera" -> {
                    oneToOneVideo?.swapCamera()
                    result.success("")
                }
                "toggleAudio" -> {
                    val publishAudio = requireNotNull(call.argument<Boolean>("publishAudio"))
                    oneToOneVideo?.toggleAudio(publishAudio)
                    result.success("")
                }
                "toggleVideo" -> {
                    val publishVideo = requireNotNull(call.argument<Boolean>("publishVideo"))
                    oneToOneVideo?.toggleVideo(publishVideo)
                    result.success("")
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    fun updateFlutterState(state: SdkState, channel: String) {
        Handler(Looper.getMainLooper()).post {
            flutterEngine?.dartExecutor?.binaryMessenger?.let {
                MethodChannel(it, channel)
                    .invokeMethod("updateState", state.toString())
            }
        }
    }
}