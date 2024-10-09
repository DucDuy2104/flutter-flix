import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';
import 'package:flutter_flix/main.dart';
import 'package:flutter_flix/providers/theme_manager.dart';
import 'package:provider/provider.dart';

import '../models/cast.dart';

String dummyImageUrl =
    "https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj";

class CastItem extends StatelessWidget {
  Cast cast;

  CastItem(this.cast);

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeManager>().themeMode == ThemeMode.dark;
    Color textColor = isDark ? Colors.white : Colors.black;
    Color bg = isDark ? const Color(0xFF36454F) : Colors.white;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        color: bg,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipOval(
                child: Image.network(
              imageHttp + (cast.avatarPath ?? ""),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset('assets/images/white.png',
                    width: 50, height: 50);
              },
            )),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cast.name ?? "",
                      style: Theme.of(context).textTheme.titleLarge),
                  Text("character: ${cast.character}")
                ],
              ),
            ),
            Text("Actor",
                style: TextStyle(
                    color: textColor,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    height: 1.5))
          ],
        ),
      ),
    );
  }
}
