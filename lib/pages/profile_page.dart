import 'package:flutter/material.dart';
import 'package:flutter_flix/main.dart';
import 'package:flutter_flix/providers/theme_manager.dart';
import 'package:flutter_flix/widgets/tool_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeManager>().themeMode == ThemeMode.dark;
    String backIcon =
        isDark ? "assets/images/back.png" : "assets/images/back_b.png";
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            children: [
              ToolBar(backIcon, "Profile", null, leftIconTap: () {
                Navigator.pop(context);
              }),
              Expanded(
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: 'avatar-hero',
                      child: ClipOval(
                          child: Image.asset('assets/images/flutter_icon.png',
                              width: 130.0, height: 130.0, fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 20),
                    Text("User's Name",
                        style: Theme.of(context).textTheme.titleLarge),
                    Text("user@gmail.com",
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            decoration: TextDecoration.none))
                  ],
                )),
              )
            ],
          )),
    );
  }
}
