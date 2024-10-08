import 'package:flutter/material.dart';
import 'package:flutter_flix/main.dart';
import 'package:flutter_flix/providers/theme_manager.dart';
import 'package:flutter_flix/values/app_colors.dart';
import 'package:provider/provider.dart';



class CustomInput extends StatelessWidget {
  final onSubmit;
  final controller;
  const CustomInput({super.key, this.onSubmit, this.controller});


  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeManager>().themeMode == ThemeMode.dark;
    return Row(
      children: [
        Expanded(child: TextField(
          controller: controller,
          onSubmitted: onSubmit,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(
                color: hintColor,
                fontSize: 14,
                height: 1.5,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 24.0),
            filled: true,
            fillColor: isDark ?  inputBg : Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16.0)
            ),
            suffixIcon: const Icon(Icons.search, size: 16.0,color: hintColor,)

          ),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 14,
            height: 1.5,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400
          ),
        ))
      ],
    );
  }

}
