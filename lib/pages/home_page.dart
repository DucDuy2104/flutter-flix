import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';
import 'package:flutter_flix/models/movie.dart';
import 'package:flutter_flix/pages/movie_detail.dart';
import 'package:flutter_flix/providers/movies_provider.dart';
import '../values/app_colors.dart';
import 'package:flutter_flix/widgets/hot_movie_item.dart';
import 'package:flutter_flix/widgets/search_input.dart';
import 'package:provider/provider.dart';

import '../api/repos.dart';

class HomePage extends StatefulWidget {
  final onChangeTheme;
  const HomePage({super.key, this.onChangeTheme});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  Repository repo = Repository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startFetch(context);
    });
  }

  Future<void> startFetch(BuildContext context) async {
    await Future.wait([
      fetchMoviesPopular(context),
      fetchMoviesNowPlaying(context),
      fetchUpcomingMovies(context),
      fetchTopRateMovies(context),
    ]);
  }

  Future<void> fetchMoviesPopular(BuildContext context) async {
    try {
      List<Movie> fetchedMovies = await repo.getMovies("/movie/popular");
      debugPrint("popular movies: ${fetchedMovies.length}");
      context
          .read<MoviesProvider>()
          .setMovies(fetchedMovies, MovieTypes.popular);
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchMoviesNowPlaying(BuildContext context) async {
    try {
      List<Movie> fetchedMovies = await repo.getMovies('/movie/now_playing');
      debugPrint("now playing movies: ${fetchedMovies.length}");
      context
          .read<MoviesProvider>()
          .setMovies(fetchedMovies, MovieTypes.nowPlaying);
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchUpcomingMovies(BuildContext context) async {
    try {
      List<Movie> fetchedMovies = await repo.getMovies('/movie/upcoming');
      debugPrint("upcoming movies: ${fetchedMovies.length}");
      context
          .read<MoviesProvider>()
          .setMovies(fetchedMovies, MovieTypes.upcoming);
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchTopRateMovies(BuildContext context) async {
    try {
      List<Movie> fetchedMovies = await repo.getMovies('/movie/top_rated');
      debugPrint("top rate movies: ${fetchedMovies.length}");
      context
          .read<MoviesProvider>()
          .setMovies(fetchedMovies, MovieTypes.topRate);
      debugPrint("top rate: ${fetchedMovies.length}");
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> moviesUpComing =
        context.watch<MoviesProvider>().mUpcomingMovies;
    List<Movie> moviesTopRate = context.watch<MoviesProvider>().mTopRateMovies;
    List<Movie> moviesNowPlaying = context.watch<MoviesProvider>().mNowPlaying;
    List<Movie> moviesPopular = context.watch<MoviesProvider>().mPopularMovies;
    debugPrint(
        "${moviesUpComing.length}${moviesPopular.length}${moviesNowPlaying.length}${moviesTopRate.length}");
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Switch(value: false, onChanged: (value) {

                    })

                  ]),
              const SizedBox(height: 23.0),
              const CustomInput(),
              const SizedBox(height: 21.0),
              SizedBox(
                height: 260,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (moviesPopular.isEmpty) {
                        return const SizedBox();
                      }
                      var movie = moviesPopular[index];
                      return HotMovieItem(index + 1, movie.posterPath,
                          onItemTab: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailPage(movie.id ?? 1)));
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
                        tabAlignment: TabAlignment.start,
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
                            Center(child: MovieGrid(moviesNowPlaying)),
                            Center(child: MovieGrid(moviesUpComing)),
                            Center(child: MovieGrid(moviesTopRate)),
                            Center(child: MovieGrid(moviesPopular)),
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
      child: RefreshIndicator(
        onRefresh: () async {},
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
      ),
    );
  }
}
