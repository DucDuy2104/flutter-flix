import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/utils//app_colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: darkBg,
      child: const Center(
        child: Text("Search" , style: TextStyle(color: Colors.white)),
      ),
    );
  }


}