import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_size.dart';

class ToolBar extends StatelessWidget {
  late final String leftIcon;
  late final String title;
  late final String? rightIcon;
  final leftIconTap;
  final rightIconTap;

  ToolBar(this.leftIcon, this.title, this.rightIcon,
      {this.leftIconTap, this.rightIconTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: leftIconTap,
          child: Image.asset(leftIcon!,
              width: iconSize, height: iconSize, fit: BoxFit.cover),
        ),
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
                height: 1.5,
                color: Colors.white)),
        rightIcon != null
            ? GestureDetector(
                onTap: rightIconTap,
                child: Image.asset(rightIcon!,
                    width: iconSize, height: iconSize, fit: BoxFit.cover),
              )
            : const SizedBox(width: iconSize, height: iconSize)
      ],
    );
  }
}
