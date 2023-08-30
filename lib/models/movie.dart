class Movie {
  final String title;
  final String picture;
  final String release_date;
  final double vote_average;

  Movie({
    required this.title,
    required this.picture,
    required this.release_date,
    required this.vote_average,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json["title"] as String,
        picture: json["poster_path"] as String,
        release_date: json["release_date"] as String,
        vote_average: (json["vote_average"] as num).toDouble()); //Ép về double
  }
}
