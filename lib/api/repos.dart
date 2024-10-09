import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flix/api/constants.dart';
import '../models/cast.dart';
import '../models/movie.dart';
import 'package:http/http.dart' as http;

import '../models/review.dart';

class Repository {
  Future<List<Movie>> getMovies(String endpoint, {int page = 1}) async {
    List<Movie> movies = [];

    var url = '$baseUrl$endpoint?api_key=$apiKey&page=$page';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      debugPrint("Request completed: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> moviesJson = jsonResponse['results'] ?? [];
        movies = moviesJson.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint("Error fetching movies: $error");
    }

    return movies;
  }

  Future<Movie?> getMovieDetail(int id) async {
    var url = '$baseUrl/movie/$id?api_key=$apiKey';
    final uri = Uri.parse(url);
    final Movie movie;
    try {
      final response = await http.get(uri);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        movie = Movie.fromJson(jsonResponse);
        return movie;
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error fetching movies: $e");
    }
    return null;
  }

  Future<List<Movie>> searchMovies(String key) async {
    List<Movie> movies = [];
    try {
      if (key == '') {
        throw Exception('khong co key');
      }
      var url = '$baseUrl/search/movie?api_key=$apiKey&query=$key}';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonMovies = json.decode(response.body);
        List<dynamic> moviesJson = jsonMovies['results'];
        movies = moviesJson.map((e) => Movie.fromJson(e)).toList();
      }
    } catch (_e) {
      debugPrint('bug: $_e');
    }
    return movies;
  }

  Future<List<Review>> getReviews(int movieId) async {
    debugPrint("get reviews...");
    List<Review> reviews = [];
    var url = '$baseUrl/movie/$movieId/reviews?api_key=$apiKey';
    var uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> reviewsJson = jsonResponse['results'];
        reviews = reviewsJson
            .map((reviewJson) => Review.fromJson(reviewJson))
            .toList();
      } else {
        throw Exception('Failed to load reviews: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Có lỗi lấy reviews: $e");
    }

    return reviews;
  }

  Future<List<Cast>> getCasts(int movieId)async {
    debugPrint("get cast...");
    List<Cast> casts = [];
    var url = '$baseUrl/movie/$movieId/credits?api_key=$apiKey';
    var uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if(response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> castsJson = jsonResponse['cast'];
        casts = castsJson.map((e) => Cast.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load reviews: ${response.statusCode}');
      }
    } catch(e) {
      debugPrint("Lỗi khi lấy casts $e");
    }
    return casts;
  }


}
