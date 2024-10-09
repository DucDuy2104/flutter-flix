import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';
import 'package:flutter_flix/api/repos.dart';
import 'package:flutter_flix/pages/movie_detail.dart';
import 'package:flutter_flix/providers/movies_provider.dart';
import 'package:flutter_flix/widgets/search_input.dart';
import 'package:flutter_flix/widgets/tool_bar.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/theme_manager.dart';
import '../widgets/watch_list_movie_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  Repository repo = Repository();
  List<Movie> mSearchMovies = [];

  Future<void> _submit(String text) async {
    debugPrint("submit...");
    List<Movie> movies = await repo.searchMovies(text);
    setState(() {
      mSearchMovies = movies;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> moviesPopular = context.watch<MoviesProvider>().mPopularMovies;
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  const ToolBar(null, "Search", null),
                  const SizedBox(height: 20),
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 150,
                        aspectRatio: 16 / 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3)),
                    items: moviesPopular.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:  (builder) => MovieDetailPage(i.id ?? 2)));
                            },
                            child: Container(
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: CachedNetworkImage(
                                      imageUrl:  imageHttp + (i.backdropPath ?? ""),
                                      width: double.infinity,
                                      height: 150),
                                )),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  CustomInput(controller: _controller, onSubmit: _submit),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 450,
                    child: mSearchMovies.isEmpty
                        ? Center(
                            child: Text(
                              "No results found", // Hiển thị khi danh sách trống
                              style: TextStyle(color: context.watch<ThemeManager>().themeMode == ThemeMode.dark ?  Colors.white : Colors.black),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              final movie = mSearchMovies[index];
                              return WatchListMovieItem(movie, onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (builder) => MovieDetailPage(movie.id ?? 1)));
                              });
                            },
                            itemCount: mSearchMovies.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 10);
                            },
                          ),
                  ),
                ],
              )),
        ));
  }
}
