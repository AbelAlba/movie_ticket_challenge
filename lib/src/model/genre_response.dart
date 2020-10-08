import 'package:movie_ticket_challenge/src/model/genre.dart';

class GenreResponse{
  final List<Genre> movies;
  final String error;
  
  GenreResponse(this.movies, this.error);

  GenreResponse.fromJson(Map<String , dynamic> json)
  :movies = (json['results'] as List).map((e) => new Genre.fromJson(e)).toList(),
  error='';

  GenreResponse.withError(String errorValue):
  movies = List(),
  error='errorValue';
}