class Movie {
  final String title;
  final String runtime;
  final String imdbRating;
  final String plot;
  final String genre;
  final List<String> images;

  Movie({
    required this.title,
    required this.runtime,
    required this.imdbRating,
    required this.plot,
    required this.genre,
    required this.images,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      runtime: json['Runtime'],
      plot: json['Plot'],
      genre: json['Genre'],
      imdbRating: json['imdbRating'],
      images: List<String>.from(json['Images']),
    );
  }

  @override
  String toString() {
    return 'Movie(title: $title, runtime: $runtime, imdbRating: $imdbRating, plot:$plot, genre:$genre, images: $images)';
  }
}
