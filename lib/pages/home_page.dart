import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';
import 'package:flutter_flix/models/movie.dart';
import 'package:flutter_flix/pages/movie_detail.dart';
import 'package:flutter_flix/utils//app_colors.dart';
import 'package:flutter_flix/utils/app_string.dart';
import 'package:flutter_flix/widgets/hot_movie_item.dart';
import 'package:flutter_flix/widgets/search_input.dart';

import '../api/repos.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  late List<Movie> popularMovies,
      nowPlayingMovies,
      upcomingMovies,
      topRateMovies;

  Repository repo = Repository();

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchMoviesPopular();
      fetchMoviesNowPlaying();
      fetchUpcomingMovies();
      fetchTopRateMovies();
    });
  }

  Future<void> fetchMoviesPopular() async {
    try {
      List<Movie> fetchedMovies = await repo.getMovies("/movie/popular");
      setState(() {
        popularMovies = fetchedMovies;
      });
      debugPrint(popularMovies.length.toString());
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchMoviesNowPlaying() async {
    try {
      List<Movie> fetchedMovies = await repo.getMovies('/movie/now_playing');
      setState(() {
        nowPlayingMovies = fetchedMovies;
      });
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchUpcomingMovies() async {
    try {
      List<Movie> fetchedMovies = await repo.getMovies('/movie/upcoming');
      setState(() {
        upcomingMovies = fetchedMovies;
      });
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchTopRateMovies() async {
    try {
      List<Movie> fetchedMovies = await repo.getMovies('/movie/top_rated');
      setState(() {
        topRateMovies = fetchedMovies;
      });
      debugPrint("top rate: ${fetchedMovies.length}");
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

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
                      return HotMovieItem(
                          index + 1, popularMovies[index].posterPath,
                          onItemTab: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailPage(
                                    popularMovies[index].id ?? 1)));
                      });
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
                              "Up coming",
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
                            Center(child: MovieGrid(nowPlayingMovies)),
                            Center(child: MovieGrid(upcomingMovies)),
                            Center(child: MovieGrid(topRateMovies)),
                            Center(child: MovieGrid(popularMovies)),
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
  final List<Movie> _list;

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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailPage(_list[index].id ?? 1)));
                },
                child: Image.network(
                    imageHttp + (_list[index].posterPath ?? ""),
                    width: 100.0,
                    height: 145.0,
                    fit: BoxFit.cover),
              ));
        }),
      ),
    );
  }
}
