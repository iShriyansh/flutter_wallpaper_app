import 'dart:typed_data';
import 'package:flutter/services.dart';
import '../viewmodel/model/wallpaper_manager.dart';

class WallpaperManagerImpl extends WallpaperManager {
  static const String setWallpaperMethodName = "setWallpaper";
  static const String channel = "com.shriyansh.wallpaper_x/wallpaper";
  final MethodChannel wallpaperChannel = const MethodChannel(channel);

  @override
  Future<bool> setWallpaper(String imageURL, String screenName) async {
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageURL)).load(imageURL))
            .buffer
            .asUint8List();

    var payload = {"wallpaper": bytes, "screenName": screenName};
    bool isWallpaperSet =
        await wallpaperChannel.invokeMethod(setWallpaperMethodName, payload);

    return isWallpaperSet;
  }
}
