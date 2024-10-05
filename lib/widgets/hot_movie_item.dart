import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/utils//app_colors.dart';
import 'package:flutter_flix/utils/app_string.dart';

class HotMovieItem extends StatelessWidget {
  const HotMovieItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50, left: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              movieThumbUrl,
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
                  "1",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 93,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 0.5
                        ..color = const Color(0xFF0296E5)),
                ),
                const Text("1",
                    style: TextStyle(
                        color: darkBg,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 93))
              ],
            ),
          )
        ],
      ),
    );
  }
}
