import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';
import 'package:flutter_flix/api/repos.dart';
import 'package:flutter_flix/utils/shared_preferences.dart';
import 'package:flutter_flix/values/app_colors.dart';
import 'package:flutter_flix/values/app_size.dart';
import 'package:flutter_flix/values/app_string.dart';
import 'package:flutter_flix/widgets/tool_bar.dart';

import '../models/movie.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  final repos = Repository();

  MovieDetailPage(this.id, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailPage();
  }
}

class _MovieDetailPage extends State<MovieDetailPage> {
  late int _id;
  Movie? movie;
  bool isLike = false;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    getMovie();
  }

  Future<void> check(Movie m) async {
    bool liked = await checkLike(m);
    setState(() {
      isLike = liked;
    });
  }

  Future<void> getMovie() async {
    try {
      final Movie fetchedMovie = (await widget.repos.getMovieDetail(_id))!;
      check(fetchedMovie);
      setState(() {
        movie = fetchedMovie;
      });
    } catch (e) {
      print("lỗi rồi $e");
    }
  }

  Future<void> saveOrDelete() async {
    await addOrDeleteMovie(movie!);
    check(movie!);
  }

  @override
  Widget build(BuildContext context) {
    if (movie == null) {
      return const SizedBox();
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: darkBg,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ToolBar(
                        "assets/images/back.png",
                        "Detail",
                        isLike
                            ? "assets/images/marked.png"
                            : "assets/images/not_mark.png",
                        leftIconTap: () {
                          Navigator.pop(context);
                        },
                        rightIconTap: () {
                          saveOrDelete();
                        },
                      )),
                  const SizedBox(height: 20.0),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0)),
                          child: Image.network(
                              imageHttp + (movie?.backdropPath ?? ""),
                              width: double.infinity,
                              height: 210,
                              fit: BoxFit.cover)),
                      Positioned(
                        bottom: 10,
                        right: 20,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                            child: Container(
                              width: 54,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                // Màu nền mờ
                                borderRadius: BorderRadius.circular(
                                    8), // Bo tròn góc nếu cần
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.star_border,
                                        color: Color(0xFFFF8700), size: 16),
                                    const SizedBox(width: 3),
                                    Text(
                                      movie?.rate!.toStringAsFixed(1) ?? "",
                                      style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          height: 1.5,
                                          color: Color(0xFFFF8700)),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: -60,
                        child: Hero(
                          tag: 'hero-image',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                                imageHttp + (movie?.posterPath ?? ""),
                                width: 95,
                                height: 120),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -60,
                        left: 140,
                        child: SizedBox(
                          width: 210,
                          child: Text(movie?.name ?? "",
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 90),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/calendar.png",
                          width: 16, height: 16, fit: BoxFit.cover),
                      const SizedBox(width: 3),
                      Text(movie?.releaseDate!.substring(0, 4) ?? "",
                          style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textGray,
                              height: 1.2)),
                      const SizedBox(width: 5),
                      Container(width: 1, height: 16, color: textGray),
                      const SizedBox(width: 5),
                      Image.asset('assets/images/clock.png'),
                      const SizedBox(width: 3),
                      const Text("148 minutes",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textGray,
                              height: 1.2)),
                      const SizedBox(width: 5),
                      Container(width: 1, height: 16, color: textGray),
                      const SizedBox(width: 5),
                      Image.asset('assets/images/ticket.png'),
                      const SizedBox(width: 3),
                      Text(movie?.genres?[0].name ?? "",
                          style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textGray,
                              height: 1.2)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DefaultTabController(
                      length: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const TabBar(
                              isScrollable: true,
                              dividerColor: Colors.transparent,
                              indicatorColor: textGray,
                              tabs: [
                                Tab(
                                  child: Text("About Movie",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.center),
                                ),
                                Tab(
                                  child: Text("Reviews",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.center),
                                ),
                                Tab(
                                  child: Text("Cast",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textAlign: TextAlign.center),
                                )
                              ]),
                          SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 30, right: 20, left: 20),
                              height: 300,
                              child: TabBarView(children: [
                                Text(movie?.description ?? "",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5)),
                                const Text(
                                    "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5)),
                                const Text(
                                    "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5))
                              ]),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
