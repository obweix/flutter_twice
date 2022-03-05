package com.example.flutter_twice;


import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkInfo;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;

import io.flutter.plugin.common.EventChannel;

public class ConnectivityBroadcastReceiver  extends BroadcastReceiver
        implements EventChannel.StreamHandler{

    public ConnectivityBroadcastReceiver(Context context) {
        this.context = context;
        connectivityManager = (ConnectivityManager)context.getSystemService(Context.CONNECTIVITY_SERVICE);
    }

    private Context context;
    private ConnectivityManager connectivityManager;
    // 回调结果
    private EventChannel.EventSink events;
    public static final String CONNECTIVITY_CHANGE = "android.net.conn.CONNECTIVITY_CHANGE";
    private Handler mainHandler = new Handler(Looper.getMainLooper());
    private ConnectivityManager.NetworkCallback networkCallback;

    @Override
    public void onReceive(Context context, Intent intent) {
        if(android.os.Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {
            NetworkInfo networkInfo = connectivityManager.getActiveNetworkInfo();
            //
            if (networkInfo != null && networkInfo.isAvailable()) {
                // network is available.
                callbackNetworkStatus(1);
            } else {
                // network is unavailable.
                callbackNetworkStatus(0);
            }
        }
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.events = events;

        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            networkCallback =
                    new ConnectivityManager.NetworkCallback() {
                        @Override
                        public void onAvailable(Network network) {
                            sendEvent(1);
                        }

                        @Override
                        public void onUnavailable() {
                            sendEvent(0);
                        }

                        @Override
                        public void onLost(Network network) {
                            sendEvent(0);
                        }
                    };
            connectivityManager.registerDefaultNetworkCallback(networkCallback);
        } else {
            context.registerReceiver(this, new IntentFilter(CONNECTIVITY_CHANGE));
        }
    }

    @Override
    public void onCancel(Object arguments) {
        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            if (networkCallback != null) {
                connectivityManager.unregisterNetworkCallback(networkCallback);
            }
        } else {
            context.unregisterReceiver(this);
        }
    }

    private void callbackNetworkStatus(int status){
        if(events != null){
            events.success(status);
        }
    }

    private void sendEvent(final int status) {
        Runnable runnable =
                new Runnable() {
                    @Override
                    public void run() {
                        events.success(status);
                    }
                };
        mainHandler.post(runnable);
    }
}
