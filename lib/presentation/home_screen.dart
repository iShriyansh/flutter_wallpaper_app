import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_x/presentation/widgets/wallpaper_grid_item.dart';
import 'package:wallpaper_x/repository/data_model/Wallpapers.dart';
import 'package:wallpaper_x/viewmodel/wallpaper_view_model.dart';

class HomeScreen extends StatelessWidget {
  final WallPaperViewModel wallpaperController = Get.put(WallPaperViewModel());

  @override
  Widget build(BuildContext context) {
    Widget _buildWallpaperGrid() {
      return GridView.builder(
          cacheExtent: 9999,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2 / 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: wallpaperController.wallpapers.length,
          itemBuilder: (context, index) {
            Photos wallpaper = wallpaperController.wallpapers[index];
            return WallpaperGridItem(imageUrl: wallpaper.src?.portrait ?? "");
          });
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: const Icon(
            Icons.format_paint_outlined,
            size: 30,
          ),
          title:
              const Text("Wallpapers X", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red[200],
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Obx(
              () => wallpaperController.wallPaperLoadingStatus == Status.success
                  ? _buildWallpaperGrid()
                  : wallpaperController.wallPaperLoadingStatus == Status.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _buildError()),
        ));
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 35,
            color: CupertinoColors.destructiveRed,
          ),
          Text(
            wallpaperController.wallpaperLoadingError ??
                "Something went wrong!",
            style: const TextStyle(
                color: CupertinoColors.destructiveRed, fontSize: 16),
          ),
          TextButton(
              onPressed: () {
                wallpaperController.fetchWallpapers();
              },
              child: const Text("Try again"))
        ],
      ),
    );
  }
}
