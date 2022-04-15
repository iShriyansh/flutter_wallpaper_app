import 'package:get/get.dart';
import 'package:wallpaper_x/model/wallpaper_manager_impl.dart';
import 'package:wallpaper_x/repository/data_model/Wallpapers.dart';
import 'package:wallpaper_x/repository/wallpaper_repository_impl.dart';
import 'package:wallpaper_x/viewmodel/model/wallpaper_manager.dart';
import 'package:wallpaper_x/viewmodel/repository/wallpaper_repository.dart';

enum Status { success, failure, loading, initial }

class WallPaperViewModel extends GetxController {
  final WallpaperRepository wallpaperRepository = WallpaperRepositoryImpl();
  final WallpaperManager wallpaperManager = WallpaperManagerImpl();
  List<Photos> wallpapers = [];
  var wallPaperLoadingStatus = Status.loading.obs;
  String? wallpaperLoadingError;

  var wallpaperSetStatus = Status.initial.obs;
  String? wallpaperSetStatusMessage;

  @override
  void onInit() {
    fetchWallpapers();
    super.onInit();
  }

  void fetchWallpapers() async {
    wallPaperLoadingStatus(Status.loading);
    wallpaperRepository.getWallpapers().then((photos) {
      wallpapers = photos.photos ?? [];
      wallPaperLoadingStatus(Status.success);
    }).catchError((e) {
      wallPaperLoadingStatus(Status.failure);
      wallpaperLoadingError = e.toString();
    });
  }

  void setWallpaper(String imageURL, String homeOrLock) async {
    wallpaperSetStatus(Status.loading);
    try {
      bool isWallpaperSet =
          await wallpaperManager.setWallpaper(imageURL, homeOrLock);
      wallpaperSetStatus(Status.success);
      Get.closeCurrentSnackbar();
      Get.back();
      Get.snackbar(
          "Success", wallpaperSetStatusMessage ?? "Applied successfully");
    } catch (e) {
      Get.snackbar(
          "Failed", wallpaperSetStatusMessage ?? "Something went wrong");
      wallpaperSetStatus(Status.initial);
    }
  }
}
