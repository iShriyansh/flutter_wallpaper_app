import 'package:wallpaper_x/viewmodel/wallpaper_view_model.dart';

abstract class WallpaperManager {
  static const lockScreen = "lockScreen";
  static const homeScreen = "homeScreen";
  static const homeAndLockScreen = "homeAndLockScreen";

  Future setWallpaper(String imageURL, String screeName);
}
