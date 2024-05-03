import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/pages/movie_details_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.movie,
                size: 24,
              ),
              SizedBox(width: 8),
              Text('Movie App',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            ],
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: MyHttpWidget(),
    );
  }
}

class MyHttpWidget extends StatefulWidget {
  final movieUri =
      'https://670ef2d6-dbdd-454c-b4d7-6960afb18cc2.mock.pstmn.io/movies';
  const MyHttpWidget({super.key});

  @override
  State<MyHttpWidget> createState() => _MyHttpWidgetState();
}

class _MyHttpWidgetState extends State<MyHttpWidget> {
  bool isLoading = true;
  List<Movie> movies = [];

  Future<List<Movie>> _loadMovies() async {
    await Future.delayed(const Duration(seconds: 3));
    final response = await http.get(Uri.parse(widget.movieUri));
    var returnValue = <Movie>[];

    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body) as List;
      returnValue = List.generate(movies.length,
          (index) => Movie.fromJson(movies[index] as Map<String, dynamic>));
      isLoading = false;
    }
    return returnValue;
  }

  @override
  void initState() {
    super.initState();
    _loadMovies().then((value) => setState(() => movies = value));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(movie: movie),
                        ),
                      );
                    },
                    child: MovieCard(
                      title: movie.title,
                      runtime: movie.runtime,
                      imdbRating: movie.imdbRating,
                      images: movie.images,
                    ),
                  );
                }));
  }
}
