import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/config/domain/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/config/domain/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/movie/',
    queryParameters: {
      'languaje': 'es-ES',
      'Authorization': Environment.bearerToken
    },
    connectTimeout: const Duration(seconds: 6),
    receiveTimeout: const Duration(seconds: 4),
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/now_playing');

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies =
        movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb)).toList();

    return movies;
  }
}
