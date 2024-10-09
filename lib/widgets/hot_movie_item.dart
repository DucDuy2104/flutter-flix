import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/main.dart';
import 'package:flutter_flix/providers/theme_manager.dart';
import 'package:provider/provider.dart';

import '../api/constants.dart';
import '../values/app_colors.dart';

class HotMovieItem extends StatelessWidget {
  final int? id;
  final String? posterPath;
  final onItemTab;

  const HotMovieItem(this.id, this.posterPath, {super.key, this.onItemTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTab ?? () {
        print("oke");
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 50, left: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                  imageUrl:  imageHttp + posterPath!,
                  height: 210,
                  width: 145,
                  fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: -50,
              left: -12,
              child: Stack(
                children: [
                  Text(
                    id.toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 93,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 0.5
                          ..color = const Color(0xFF0296E5)),
                  ),
                  Text(id.toString(),
                      style: TextStyle(
                          color: context.watch<ThemeManager>().themeMode == ThemeMode.dark ? Color(0xFF242A32) : Color(0xFF0296E5),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 93))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
