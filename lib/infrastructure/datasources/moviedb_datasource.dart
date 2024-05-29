import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

/// Clase que pilla las películas de MoviesDB tal como las tienen ellos
/// y las devuelve en una lista de películas tal como necesita
/// nuestra lógica de negocio despues de flitratlas y mapearlas.
///
class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/movie/',
    headers: {"authorization": "Bearer ${Environment.bearerToken}"},
    connectTimeout: const Duration(seconds: 9),
    receiveTimeout: const Duration(seconds: 6),
  ));

  List<Movie> _json2Movies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/now_playing',
      queryParameters: {'language': 'es-ES', 'page': page},
    );

    return _json2Movies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/popular',
      queryParameters: {'language': 'es-ES', 'page': page},
    );

    return _json2Movies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/upcoming',
      queryParameters: {'page': page, 'language': 'es-ES'},
    );

    return _json2Movies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/top_rated',
      queryParameters: {'language': 'es-ES', 'page': page},
    );

    return _json2Movies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    
    final response = await dio.get(
      '/$id',
      queryParameters: {'language': 'es-ES'},
    );

    if (response.statusCode != 200) throw Exception('*** Movie with id $id not found');

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailToEntity(movieDetails);


    return movie;
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async {
    
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query,  'language': 'es-ES' },
    );

    return _json2Movies(response.data);
  }

}
