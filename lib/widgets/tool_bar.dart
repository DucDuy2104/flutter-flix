import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/main.dart';
import 'package:flutter_flix/providers/theme_manager.dart';
import 'package:flutter_flix/values/app_size.dart';
import 'package:provider/provider.dart';


class ToolBar extends StatelessWidget {
  final String? leftIcon;
  final String title;
  final String? rightIcon;
  final leftIconTap;
  final rightIconTap;

  const ToolBar(this.leftIcon, this.title, this.rightIcon,
      {super.key, this.leftIconTap, this.rightIconTap});

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeManager>().themeMode == ThemeMode.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leftIcon != null
            ? GestureDetector(
                onTap: leftIconTap,
                child: Image.asset(leftIcon!,
                    width: iconSize, height: iconSize, fit: BoxFit.cover),
              )
            : const SizedBox(width: iconSize, height: iconSize),
        Text(title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
                height: 1.5,
                color: isDark? Colors.white : Colors.black)),
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
