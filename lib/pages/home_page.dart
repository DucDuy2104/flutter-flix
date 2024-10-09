import 'package:flutter/material.dart';
import 'package:flutter_flix/api/constants.dart';
import 'package:flutter_flix/models/movie.dart';
import 'package:flutter_flix/pages/movie_detail.dart';
import 'package:flutter_flix/pages/profile_page.dart';
import 'package:flutter_flix/providers/movies_provider.dart';
import 'package:flutter_flix/providers/theme_manager.dart';
import 'package:flutter_flix/widgets/hot_movie_item.dart';
import 'package:flutter_flix/widgets/search_input.dart';
import 'package:provider/provider.dart';
import '../api/repos.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  Repository repo = Repository();
  final ScrollController _popularMoviesController = ScrollController();
  final ScrollController _topRateMoviesController = ScrollController();
  final ScrollController _nowPlayingMoviesController = ScrollController();
  final ScrollController _upComingMoviesController = ScrollController();
  int popularPage = 1;
  int nowPlayingPage = 1;
  int upComingPage = 1;
  int topRatePage = 1;

  @override
  void initState() {
    super.initState();
    _popularMoviesController.addListener(() {
      if (_popularMoviesController.hasClients) {
        if (_popularMoviesController.position.atEdge) {
          bool isEnd = _popularMoviesController.position.pixels ==
              _popularMoviesController.position.maxScrollExtent;
          if (isEnd) {
            fetchMoviesPopular(context);
          }
        }
      }
    });
    _topRateMoviesController.addListener(() {
      if (_topRateMoviesController.hasClients) {
        if (_topRateMoviesController.position.atEdge) {
          bool isEnd = _topRateMoviesController.position.pixels ==
              _topRateMoviesController.position.maxScrollExtent;
          if (isEnd) {
            fetchTopRateMovies(context);
          }
        }
      }
    });
    _upComingMoviesController.addListener(() {
      if (_upComingMoviesController.hasClients) {
        if (_upComingMoviesController.position.atEdge) {
          bool isEnd = _upComingMoviesController.position.pixels ==
              _upComingMoviesController.position.maxScrollExtent;
          if (isEnd) {
            fetchUpcomingMovies(context);
          }
        }
      }
    });
    _nowPlayingMoviesController.addListener(() {
      if (_nowPlayingMoviesController.hasClients) {
        if (_nowPlayingMoviesController.position.atEdge) {
          bool isEnd = _nowPlayingMoviesController.position.pixels ==
              _nowPlayingMoviesController.position.maxScrollExtent;
          if (isEnd) {
            fetchMoviesNowPlaying(context);
          }
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startFetch(context);
    });
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
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
      List<Movie> fetchedMovies =
          await repo.getMovies("/movie/popular", page: popularPage);
      debugPrint("popular movies: ${fetchedMovies.length}");
      context
          .read<MoviesProvider>()
          .addMovies(fetchedMovies, MovieTypes.popular);
      setState(() {
        popularPage += 1;
      });
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchMoviesNowPlaying(BuildContext context) async {
    try {
      List<Movie> fetchedMovies =
          await repo.getMovies('/movie/now_playing', page: nowPlayingPage);
      debugPrint("now playing movies: ${fetchedMovies.length}");
      context
          .read<MoviesProvider>()
          .addMovies(fetchedMovies, MovieTypes.nowPlaying);
      setState(() {
        nowPlayingPage += 1;
      });
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchUpcomingMovies(BuildContext context) async {
    try {
      List<Movie> fetchedMovies =
          await repo.getMovies('/movie/upcoming', page: upComingPage);
      debugPrint("upcoming movies: ${fetchedMovies.length}");
      context
          .read<MoviesProvider>()
          .addMovies(fetchedMovies, MovieTypes.upcoming);
      setState(() {
        upComingPage += 1;
      });
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  Future<void> fetchTopRateMovies(BuildContext context) async {
    try {
      List<Movie> fetchedMovies =
          await repo.getMovies('/movie/top_rated', page: topRatePage);
      debugPrint("top rate movies: ${fetchedMovies.length}");
      context
          .read<MoviesProvider>()
          .addMovies(fetchedMovies, MovieTypes.topRate);
      setState(() {
        topRatePage += 1;
      });
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeManager>().themeMode == ThemeMode.dark;
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
      color: Theme.of(context).colorScheme.primary,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ProfilePage()));
                      },
                      child: Hero(
                        tag: 'avatar-hero',
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/flutter_icon.png",
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "What do you want to watch?",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Switch(
                      value: context.watch<ThemeManager>().themeMode ==
                          ThemeMode.dark,
                      onChanged: (value) {
                        context.read<ThemeManager>().toggleTheme(value);
                      },
                      activeColor: Colors.white,
                    ),
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
                    itemCount: 5),
              ),
              DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        tabAlignment: TabAlignment.start,
                        tabs: [
                          Tab(
                            child: Text(
                              maxLines: 1,
                              "Now playing",
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
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
                                color: isDark ? Colors.white : Colors.black,
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
                                color: isDark ? Colors.white : Colors.black,
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
                                color: isDark ? Colors.white : Colors.black,
                                height: 1.5,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                        indicatorColor: const Color(0xFF3A3F47),
                        indicatorWeight: 4.0,
                      ),
                      SizedBox(
                        height: 300,
                        child: TabBarView(children: [
                          Center(
                              child: MovieGrid(moviesNowPlaying,
                                  _nowPlayingMoviesController)),
                          Center(
                              child: MovieGrid(
                                  moviesUpComing, _upComingMoviesController)),
                          Center(
                              child: MovieGrid(
                                  moviesTopRate, _topRateMoviesController)),
                          Center(
                              child: MovieGrid(
                                  moviesPopular, _popularMoviesController)),
                        ]),
                      )
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
  ScrollController scrollController;

  MovieGrid(this._list, this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: GridView.count(
          controller: scrollController,
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
