import 'package:flutter/material.dart';
import 'package:flutter_flix/utils//app_colors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextField(
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
            fillColor: inputBg,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16.0)
            ),
            suffixIcon: const Icon(Icons.search, size: 16.0,color: hintColor,)

          ),
          style: const TextStyle(
            color: Colors.white,
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
