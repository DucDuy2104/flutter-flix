import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_size.dart';

class ToolBar extends StatelessWidget {
  late final String leftIcon;
  late final String title;
  late final String? rightIcon;

  ToolBar(this.leftIcon, this.title, this.rightIcon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(leftIcon!,
            width: iconSize, height: iconSize, fit: BoxFit.cover),
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
                height: 1.5,
                color: Colors.white)),
        rightIcon != null
            ? Image.asset(rightIcon!,
                width: iconSize, height: iconSize, fit: BoxFit.cover)
            : const SizedBox(width: iconSize, height: iconSize)
      ],
    );
  }
}
