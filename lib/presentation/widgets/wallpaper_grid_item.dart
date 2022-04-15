import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_x/presentation/wallpaper_preview.dart';

class WallpaperGridItem extends StatelessWidget {
  final String imageUrl;

  const WallpaperGridItem({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WallpaperPreview(wallpaperURL: imageUrl));
      },
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const CupertinoActivityIndicator();
                },
              ))),
    );
  }
}
