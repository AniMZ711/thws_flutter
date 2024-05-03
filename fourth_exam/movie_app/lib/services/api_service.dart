import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie.dart';
import 'dart:convert';

class ApiService {
  final movieUri =
      'https://670ef2d6-dbdd-454c-b4d7-6960afb18cc2.mock.pstmn.io/movies';

  Future<List<Movie>> loadMovies() async {
    await Future.delayed(const Duration(seconds: 3));
    final response = await http.get(Uri.parse(movieUri));
    var returnValue = <Movie>[];

    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body) as List;
      returnValue = List.generate(movies.length,
          (index) => Movie.fromJson(movies[index] as Map<String, dynamic>));
    }
    return returnValue;
  }
}
