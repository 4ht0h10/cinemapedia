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
    headers:  { "authorization": "Bearer ${Environment.bearerToken}" },
    queryParameters: { 'languaje': 'es-ES' },
    connectTimeout: const Duration(seconds: 6),
    receiveTimeout: const Duration(seconds: 5),
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
