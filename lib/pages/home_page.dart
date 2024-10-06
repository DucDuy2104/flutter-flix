import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_flix/utils//app_colors.dart';
import 'package:flutter_flix/utils/app_string.dart';
import 'package:flutter_flix/widgets/hot_movie_item.dart';
import 'package:flutter_flix/widgets/search_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: darkBg,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What do you want to watch?",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.5),
              ),
              const SizedBox(height: 23.0),
              const CustomInput(),
              const SizedBox(height: 21.0),
              SizedBox(
                height: 260,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const HotMovieItem();
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 20.0);
                    },
                    itemCount: 20),
              ),
              DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      const TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(
                            child: Text(
                              maxLines: 1,
                              "Now playing",
                              style: TextStyle(
                                color: Colors.white,
                                height: 1.5,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              maxLines: 1,
                              "Up comming",
                              style: TextStyle(
                                color: Colors.white,
                                height: 1.5,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              maxLines: 1,
                              "Top rate",
                              style: TextStyle(
                                color: Colors.white,
                                height: 1.5,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              maxLines: 1,
                              "Popular",
                              style: TextStyle(
                                color: Colors.white,
                                height: 1.5,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                        indicatorColor: Color(0xFF3A3F47),
                        indicatorWeight: 4.0,
                      ),
                      SizedBox(
                          height: 300,
                          child: TabBarView(children: [
                            Center(
                                child: MovieGrid(const [
                                  movieThumbUrl,
                                  movieThumbUrl,
                                  movieThumbUrl,
                                  movieThumbUrl,
                                  movieThumbUrl,
                                  movieThumbUrl,
                                  movieThumbUrl,
                                  movieThumbUrl
                                ])),
                            const Center(child: Text("Upcoming")),
                            const Center(child: Text("Top rated")),
                            const Center(child: Text("Popular")),
                          ]))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final List<String> _list;

  MovieGrid(this._list, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: 0.75,
        padding: const EdgeInsets.only(bottom: 10.0),

        children: List.generate(_list.length, (index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(_list[index],
                  width: 100.0, height: 145.0, fit: BoxFit.cover));
        }),
      ),
    );
  }
}
