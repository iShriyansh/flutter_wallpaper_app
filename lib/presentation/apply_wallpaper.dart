import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_x/viewmodel/model/wallpaper_manager.dart';
import 'package:wallpaper_x/viewmodel/wallpaper_view_model.dart';

class ApplyWallpaper extends StatelessWidget {
  final String wallpaperURL;

  ApplyWallpaper({Key? key, required this.wallpaperURL}) : super(key: key);

  final WallPaperViewModel _wallPaperViewModel = Get.find();

  void _setWallpaper() async {
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(left: 32, top: 16, bottom: 16),
          child: SafeArea(
              child: Obx(() =>
                  _wallPaperViewModel.wallpaperSetStatus == Status.loading
                      ? _buildLoading()
                      : _buildWallpaperOptions())),
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )));
  }

  Widget _buildLoading() {
    return Row(
      children: const [
        SizedBox(
          width: 16,
        ),
        Text(
          "Applying...",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildWallpaperOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _applyWallpaperOption(() {
          _wallPaperViewModel.setWallpaper(
              wallpaperURL, WallpaperManager.homeScreen);
        }, "Set Wallpaper", Icons.wallpaper),
        _applyWallpaperOption(
          () {
            _wallPaperViewModel.setWallpaper(
                wallpaperURL, WallpaperManager.lockScreen);
          },
          "Set Lock Wallpaper",
          Icons.wallpaper,
        ),
        _applyWallpaperOption(
          () {
            _wallPaperViewModel.setWallpaper(
                wallpaperURL, WallpaperManager.homeAndLockScreen);
          },
          "Set Both",
          Icons.phonelink_lock_outlined,
        ),
      ],
    );
  }

  Widget _applyWallpaperOption(
      Function onPressed, String label, IconData leadingIcon) {
    return MaterialButton(
        onPressed: () {
          onPressed();
        },
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(leadingIcon),
            const SizedBox(
              width: 16,
            ),
            Text(label),
          ],
        ));
  }

  void _checkPlatformAndSetWallpaper() {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      deviceInfoPlugin.androidInfo.then((currentPlatform) {
        if (currentPlatform.version.sdkInt == null ||
            currentPlatform.version.sdkInt! < 24) {
          _wallPaperViewModel.setWallpaper(
              wallpaperURL, WallpaperManager.homeAndLockScreen);
        } else {
          _setWallpaper();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _checkPlatformAndSetWallpaper();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red.shade50.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.imagesearch_roller,
                    size: 25,
                    color: Colors.black87,
                  ),
                  Text(
                    "Set Wallpaper",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
