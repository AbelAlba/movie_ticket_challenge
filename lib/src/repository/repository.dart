import 'package:dio/dio.dart';
import 'package:movie_ticket_challenge/src/model/data_response.dart';
import 'package:movie_ticket_challenge/src/model/genre_response.dart';

class MovieRepository{
  final String apiKey = '5735e8d24c7906f3894f6b4111e89d6b';
  static String mainUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';

  Future<MovieResponse> getMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
    };try{
      Response response = await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(error,stackTrace){
      print('Error identificado: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }
  Future<MovieResponse> getPlayingMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
    };try{
      Response response = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(error,stackTrace){
      print('Error identificado: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }
  Future<GenreResponse> getGenres() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
    };try{
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    }catch(error,stackTrace){
      print('Error identificado: $error stackTrace: $stackTrace');
      return GenreResponse.withError('$error');
    }
  }
  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
      'with_genres': id
    };try{
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch(error,stackTrace){
      print('Error identificado: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }
}