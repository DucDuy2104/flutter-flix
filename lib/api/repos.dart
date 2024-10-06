import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flix/api/constants.dart';
import '../models/movie.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<List<Movie>> getMovies(String endpoint) async {
    List<Movie> movies = [];

    var url = '$baseUrl$endpoint?api_key=$apiKey';
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
      if(response.statusCode == 200) {
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
}


