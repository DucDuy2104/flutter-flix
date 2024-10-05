import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/utils//app_colors.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: darkBg,
      child: const Center(
        child: Text("Watch List" , style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
