import 'package:wallpaper_x/repository/data_model/Wallpapers.dart';

abstract class WallpaperRepository{
  Future<Wallpapers> getWallpapers();
}