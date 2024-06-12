import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

const String ACCEPT = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String LANGUAGE = 'es-ES';
const String BASE_URL = 'https://api.themoviedb.org/3/';

/// Clase que pilla las películas de MoviesDB tal como las tienen ellos
/// y las devuelve en una lista de películas tal como necesita
/// nuestra lógica de negocio despues de flitratlas y mapearlas.
///
class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    headers: {"authorization": "Bearer ${Environment.bearerToken}",
              "Accept":        ACCEPT},
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
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
      'movie/now_playing',
      queryParameters: {'language': LANGUAGE, 'page': page},
    );

    return _json2Movies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      'movie/popular',
      queryParameters: {'language': LANGUAGE, 'page': page},
    );

    return _json2Movies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      'movie/upcoming',
      queryParameters: {'page': page, 'language': LANGUAGE},
    );

    return _json2Movies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      'movie/top_rated',
      queryParameters: {'language': LANGUAGE, 'page': page},
    );

    return _json2Movies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get(
      'movie/$id',
      queryParameters: {'language': LANGUAGE},
    );

    if (response.statusCode != 200)
      throw Exception('*** Movie with id $id not found');

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailToEntity(movieDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    // GET /3/search/movie?query=batm&include_adult=false&language=en-US&page=1 HTTP/1.1
    // Accept: application/json
    // Authorization: Bearer eyJ.. ..K_UEZA
    // Host: api.themoviedb.org

    try {
      // Bloque supervisado
      final resp = await dio.get(
        '/search/movie',
        queryParameters: {'query': query, 'language': LANGUAGE},
      );

      return _json2Movies(resp.data);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('-- Error.data = ${e.response!.data}');
        print('-- Error.headers = ${e.response!.headers}');
        print('-- Error.requestOptions = ${e.response!.requestOptions}');
        rethrow;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('-- Error.requestOptions = ${e.requestOptions}');
        print('-- Error.message = ${e.message}');
        rethrow;
      }
    }

    /*     final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query, 'language': LANGUAGE},
    ); */
  }
}
