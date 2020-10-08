class Movie{
  final int id;
  final double popularity;
  final double rating;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;

  Movie(
    this.id,
    this.popularity,
    this.rating,
    this.title,
    this.backPoster,
    this.poster,
    this.overview
  );

  Movie.fromJson(Map<String, dynamic> json):
  id = json['id'],
  popularity = json['popularity'],
  rating = json['vote_average'].toDouble(),
  title= json['title'],
  backPoster = json['backdrop_path'],
  poster = json['poster_path'],
  overview = json['overview'];
}

