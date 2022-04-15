package com.shriyansh.wallpaper_x;

import android.app.WallpaperManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import java.io.IOException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private final String CHANNEL = "com.shriyansh.wallpaper_x/wallpaper";
    private final String SET_WALLPAPER_METHOD_NAME = "setWallpaper";
    private final String HOME_SCREEN = "homeScreen";
    private final String LOCK_SCREEN = "lockScreen";
    private final String HOME_AND_LOCK_SCREEN = "homeAndLockScreen";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    switch (call.method) {

                        case SET_WALLPAPER_METHOD_NAME: {
                            SetWallpaperTask setWallpaperTask = new SetWallpaperTask(call, result);
                            setWallpaperTask.execute();
                            break;
                        }
                    }
                });
    }

    private class SetWallpaperTask extends AsyncTask<Void, Bitmap, Bitmap> {
        WallpaperManager wallpaperManager;
        final MethodCall call;
        final MethodChannel.Result result;

        public SetWallpaperTask(MethodCall methodCall, MethodChannel.Result result) {
            this.call = methodCall;
            this.result = result;
        }

        //pre Executes
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        @Override
        protected Bitmap doInBackground(Void... Voids) {
            wallpaperManager = WallpaperManager.getInstance(getApplicationContext());
            byte[] wallpaperInBytes = call.argument("wallpaper");
            Bitmap bitmap = BitmapFactory.decodeByteArray(wallpaperInBytes, 0, wallpaperInBytes.length);
            return bitmap;
        }

        //updates UI
        @Override
        protected void onPostExecute(Bitmap bitmap) {
            final String screenName = call.argument("screenName");
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    switch (screenName) {
                        case HOME_SCREEN: {
                            wallpaperManager.setBitmap(bitmap, null, false, WallpaperManager.FLAG_SYSTEM);
                            break;
                        }
                        case LOCK_SCREEN: {
                            wallpaperManager.setBitmap(bitmap, null, false, WallpaperManager.FLAG_LOCK);
                            break;
                        }
                        case HOME_AND_LOCK_SCREEN: {
                            wallpaperManager.setBitmap(bitmap);
                            break;
                        }
                    }
                    result.success(true);
                } else {
                    //Cannot set lockscreen wallpaper below SDK API - 24
                    wallpaperManager.setBitmap(bitmap);
                }

            } catch (IOException e) {
                Log.d("setWallpaperError", e.getMessage());
                result.error("FAILED", e.getMessage(), "Failed to set wallpaper");
                e.printStackTrace();
            }
        }
    }
}


