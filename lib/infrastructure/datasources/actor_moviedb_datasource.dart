

import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {


  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/movie/',
    headers: {"authorization": "Bearer ${Environment.bearerToken}"},
    connectTimeout: const Duration(seconds: 11),
    receiveTimeout: const Duration(seconds: 9),
  ));

  List<Actor> _json2Actors(Map<String, dynamic> json) {
    final actorsDBResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors = actorsDBResponse.cast
        .map((actor) => ActorMapper.Cast2Entity(actor))
        .toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {


    final response = await dio.get(
      '${ movieId }/credits',
      queryParameters: {'languaje': 'es-ES'},
    );


    return _json2Actors(response.data);
  }
  
}