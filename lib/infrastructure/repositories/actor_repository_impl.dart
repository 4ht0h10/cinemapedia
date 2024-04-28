import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actordatasource;

  ActorRepositoryImpl(this.actordatasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    
    return actordatasource.getActorsByMovie(movieId);
  }
}
