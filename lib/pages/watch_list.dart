import 'package:flutter/material.dart';
import 'package:flutter_flix/utils//app_colors.dart';
import 'package:flutter_flix/widgets/watch_list_movie_item.dart';

import '../widgets/tool_bar.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      color: darkBg,
      child: Column(children: [
        ToolBar("assets/images/back.png", "Watch List", null),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 10, // Number of items in the list
            itemBuilder: (context, index) {
              return SizedBox(
                height: 140, // Height for each item
                child: Column(
                  children: [
                    WatchListMovieItem(), // Custom widget
                    const SizedBox(height: 20), // Spacing between items
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
