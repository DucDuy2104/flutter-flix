import 'package:flutter/cupertino.dart';
import 'package:flutter_flix/models/movie.dart';

class MoviesProvider with ChangeNotifier{
  List<Movie> mPopularMovies = [];
  List<Movie> mUpcomingMovies = [];
  List<Movie> mTopRateMovies = [];
  List<Movie> mNowPlaying = [];
  void addMovies(List<Movie> movies, MovieTypes type) {
    switch(type) {
      case MovieTypes.nowPlaying:
        mNowPlaying.addAll(movies);
        break;
      case MovieTypes.upcoming:
        mUpcomingMovies.addAll(movies);
        break;
      case MovieTypes.popular:
        debugPrint("popular name before add: ${mPopularMovies.length}");
        mPopularMovies.addAll(movies);
        debugPrint("popular name after add: ${mPopularMovies.length}");
        break;
      case MovieTypes.topRate:
        mTopRateMovies.addAll(movies);
        break;
      default:
        debugPrint("No matched key!");
    }
    notifyListeners();

  }


  void setMovies(List<Movie> movies, MovieTypes type) {
    switch(type) {
      case MovieTypes.nowPlaying:
        mNowPlaying = movies;
        break;
      case MovieTypes.upcoming:
        mUpcomingMovies = movies;
        break;
      case MovieTypes.popular:
        mPopularMovies = movies;
        break;
      case MovieTypes.topRate:
        mTopRateMovies = movies;
        break;
      default:
        debugPrint("No matched key!");
    }
    notifyListeners();
  }
}

enum MovieTypes {
  nowPlaying,
  upcoming,
  popular,
  topRate
}
