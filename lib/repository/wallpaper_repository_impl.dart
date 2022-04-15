import 'package:get/get.dart';
import 'package:wallpaper_x/core/constants.dart';
import 'package:wallpaper_x/core/exception.dart';
import 'package:wallpaper_x/repository/data_model/Wallpapers.dart';
import 'package:wallpaper_x/utils/api_helper.dart';
import 'package:wallpaper_x/viewmodel/repository/wallpaper_repository.dart';

class WallpaperRepositoryImpl extends WallpaperRepository {
  RestHelper restHelper = RestHelper();

  @override
  Future<Wallpapers> getWallpapers() async {
    Response response = await restHelper.fetch(
        baseURL + "/curated?page=2&per_page=40", {"Authorization": apiKey});

    if (response.statusCode == 200) {
      return Wallpapers.fromJson(response.body);
      //Todo: Handle properly
    } else if (response.statusCode == null) {
      throw NoInternetException();
    } else {
      throw GenericException();
    }
  }
}
