import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_x/presentation/apply_wallpaper.dart';

class WallpaperPreview extends StatelessWidget {
  final String wallpaperURL;
  const WallpaperPreview({Key? key, required this.wallpaperURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body:  SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Image.network(
             wallpaperURL,
            fit: BoxFit.cover,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:ApplyWallpaper(wallpaperURL: wallpaperURL)
    );
  }
}
