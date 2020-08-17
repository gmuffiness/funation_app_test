import 'dart:convert';
import 'package:netflix_clone_practice/model/movie_model.dart';

List<Movie> parseMovies(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}
