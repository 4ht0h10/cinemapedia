import 'package:dio/dio.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {

  void configureDio() {
    /// Configuro los parámetros generales de Dio
    /// y creo la instancia.
    ///
    final opt = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/movie/',
      queryParameters: { 
        'languaje': 'es-ES',
        'Authorization': Environment.bearerToken
        },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );

    final dio = Dio(opt);
  }


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // TODO: implement getNowPlaying

    return [];
  }
}
