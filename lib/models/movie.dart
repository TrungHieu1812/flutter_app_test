class Movie {
  String? title;
  String? picture;
  String? release_date;
  dynamic vote_average;

  Movie({this.title, this.picture, this.release_date, this.vote_average});

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['original_title'],
        picture = json['poster_path'],
        release_date = json['release_date'],
        vote_average = json['vote_average'];
}

// class Picture {
//   String medium = "https://image.tmdb.org/t/p/w500/";

//   Picture({this.medium});

//   Picture.fromJson(Map<String, dynamic> json) : medium + json['large'];
// }

// class Name {
//   String? last;
//   String? first;

//   Name({this.last, this.first});

//   Name.fromJson(Map<String, dynamic> json)
//       : last = json['last'],
//         first = json['first'];
// }
