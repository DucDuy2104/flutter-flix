class Movie  {
  final int? id;
  final String? name;
  final String? posterPath;
  final String? description;
  final double? rate;
  final String? backdropPath;
  final String? releaseDate;
  final List<Genres>? genres;

  Movie({this.releaseDate, this.id, this.name, this.posterPath, this.description, this.rate,
      this.backdropPath, this.genres});

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<dynamic> genres = json['genres'] ?? [];
    List<Genres> genList = genres.map((gen) => Genres.fromJson(gen)).toList();
    return Movie(
      id: json['id'],
      name: json['title'],
      posterPath: json['poster_path'],
      description: json['overview'],
      rate: json['vote_average'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      genres: genList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "title" : name,
      "poster_path": posterPath,
      "overview" : description,
      "vote_average" : rate,
      "backdrop_path": backdropPath,
      "release_date": releaseDate
    };
  }

}


class Genres {
  final int? id;
  final String? name;

  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'],
      name: json['name']
    );
  }
}