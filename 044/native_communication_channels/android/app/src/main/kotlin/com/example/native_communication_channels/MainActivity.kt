package com.example.native_communication_channels

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "methodChannelBatteryService").setMethodCallHandler {
            call, result ->

            if (call.method == "getNativeBatteryLevel") {
                var batteryLevel = getBatteryLevel();
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("Unvailable", "Battery not available", null)
                }
            } else {
                result.notImplemented()
            }
        }

        // event channel
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "eventChannelBatteryService").setStreamHandler(BatteryLevelEventChannel(context))
    }

    // method channel
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}

// event channel
class BatteryLevelEventChannel(context: Context): EventChannel.StreamHandler {
    private var chargingStateChangeReceiver: BroadcastReceiver? = null
    private var applicationContext: Context = context

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        chargingStateChangeReceiver = createChargingStateChangeReceiver(events!!)
        applicationContext.registerReceiver(chargingStateChangeReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    }

    override fun onCancel(arguments: Any?) {
        applicationContext.unregisterReceiver(chargingStateChangeReceiver)
        chargingStateChangeReceiver = null
    }

    private fun createChargingStateChangeReceiver(events: EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val batteryPct = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                events.success(batteryPct);
            }
        }
    }
}