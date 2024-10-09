import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';
import 'package:flutter_flix/api/repos.dart';
import 'package:flutter_flix/pages/review_page.dart';
import 'package:flutter_flix/providers/theme_manager.dart';
import 'package:flutter_flix/utils/shared_preferences.dart';
import 'package:flutter_flix/values/app_colors.dart';
import 'package:flutter_flix/widgets/cast_item.dart';
import 'package:flutter_flix/widgets/review_item.dart';
import 'package:flutter_flix/widgets/tool_bar.dart';
import 'package:provider/provider.dart';
import '../models/cast.dart';
import '../models/movie.dart';
import '../models/review.dart';
import '../providers/reivews_provider.dart';

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
  List<Cast> casts = [];
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMovie(context);
    });
  }

  Future<void> check(Movie m) async {
    bool liked = await checkLike(m);
    setState(() {
      isLike = liked;
    });
  }

  Future<void> getMovie(BuildContext context) async {
    try {
      final Movie fetchedMovie = (await widget.repos.getMovieDetail(_id))!;
      check(fetchedMovie);
      getReviews(fetchedMovie, context);
      getCasts(fetchedMovie);
      setState(() {
        movie = fetchedMovie;
      });
    } catch (e) {
      print("lỗi rồi $e");
    }
  }

  Future<void> getReviews(Movie m, BuildContext context) async {
    try {
      List<Review> fetchedReivew = await widget.repos.getReviews(m.id ?? 1);
      setState(() {
        context.read<ReviewProvider>().setReviews(fetchedReivew);
      });
    } catch (e) {
      debugPrint("Lỗi $e");
    }
  }

  Future<void> getCasts(Movie e) async {
    try {
      List<Cast> fetchedCast = await widget.repos.getCasts(e.id ?? 1);
      setState(() {
        casts = fetchedCast;
      });
    } catch (e) {
      debugPrint("Lỗi $e");
    }
  }

  Future<void> saveOrDelete() async {
    await addOrDeleteMovie(movie!);
    check(movie!);
  }

  @override
  Widget build(BuildContext context) {
    List<Review> reviews = context.watch<ReviewProvider>().mReviews;
    if (movie == null) {
      return const SizedBox();
    }
    bool isDark = context.watch<ThemeManager>().themeMode == ThemeMode.dark;
    Color textColor = isDark ? Colors.white : Colors.black;
    String likeIcon = '';
    if (isDark) {
      likeIcon =
          isLike ? "assets/images/marked.png" : "assets/images/not_mark.png";
    } else {
      likeIcon = isLike
          ? "assets/images/marked_b.png"
          : "assets/images/not_mark_b.png";
    }
    String backIcon =
        isDark ? "assets/images/back.png" : "assets/images/back_b.png";
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ToolBar(
                        backIcon,
                        "Detail",
                        likeIcon,
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
                          child: CachedNetworkImage(
                              imageUrl:  imageHttp + (movie?.backdropPath ?? ""),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: CachedNetworkImage(
                              imageUrl:  imageHttp + (movie?.posterPath ?? ""),
                              width: 95,
                              height: 120),
                        ),
                      ),
                      Positioned(
                        bottom: -60,
                        left: 140,
                        child: SizedBox(
                          width: 210,
                          child: Text(movie?.name ?? "",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  color: textColor)),
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
                      const Text("2021",
                          style: TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      Expanded(
                          child: InkWell(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 50,
                            color: Colors.green,
                            child: const Center(
                                child: Icon(Icons.play_arrow, size: 20)),
                          ),
                        ),
                      )),
                      const SizedBox(width: 10),
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (builder) => ReviewPage(movie: movie)));
                            },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 50,
                            color: Colors.blueGrey,
                            child: const Center(
                                child: Icon(Icons.rate_review, size: 20)),
                          ),
                        ),
                      )),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  DefaultTabController(
                      length: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TabBar(
                              isScrollable: true,
                              dividerColor: Colors.transparent,
                              indicatorColor: textGray,
                              tabAlignment: TabAlignment.start,
                              tabs: [
                                Tab(
                                  child: Text("About Movie",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: textColor),
                                      textAlign: TextAlign.center),
                                ),
                                Tab(
                                  child: Text("Reviews",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: textColor),
                                      textAlign: TextAlign.center),
                                ),
                                Tab(
                                  child: Text("Cast",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: textColor),
                                      textAlign: TextAlign.center),
                                )
                              ]),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 30, right: 20, left: 20),
                            height: 325,
                            child: TabBarView(children: [
                              Text(movie?.description ?? "",
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.5)),
                              ListView.separated(
                                  itemBuilder: (builder, index) {
                                    return ReviewItem(reviews[index]);
                                  },
                                  separatorBuilder: (builder, index) {
                                    return const SizedBox(height: 10);
                                  },
                                  itemCount: reviews.length),
                              ListView.separated(
                                  itemBuilder: (builder, index) {
                                    return CastItem(casts[index]);
                                  },
                                  separatorBuilder: (builder, index) {
                                    return const SizedBox(height: 10);
                                  },
                                  itemCount: casts.length)
                            ]),
                          ),
                        ],
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
