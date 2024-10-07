import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie.dart';

Future<void> addOrDeleteMovie(Movie movie) async {
  debugPrint("add or delete...");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Movie> movies = await getMovies();
  bool isExist = movies.any((m) => m.id == movie.id);
  if (isExist) {
    movies.removeWhere((m) => m.id == movie.id);
    debugPrint("delete...");
  } else {
    debugPrint("add...");
    movies.add(movie);
  }
  List<String> stringMovies = movies.map((e) {
    return jsonEncode(e.toJson());
  }).toList();

  prefs.setStringList("movies", stringMovies);
}

Future<List<Movie>> getMovies() async {
  debugPrint("get movies from shared preferences...");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? moviesString = prefs.getStringList("movies");

  if (moviesString == null) {
    return [];
  }

  List<Movie> movies = moviesString.map((e) {
    Map<String, dynamic> movieMap = jsonDecode(e);
    return Movie.fromJson(movieMap);
  }).toList();

  return movies;
}

Future<bool> checkLike(Movie? movie) async {
  debugPrint("checking like....");
  if(movie == null) {
    return false;
  }
  List<Movie> movies = await getMovies();
  bool isExist = movies.any((m) => m.id == movie.id);
  return isExist;
}
