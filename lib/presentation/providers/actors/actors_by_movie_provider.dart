import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final actorsByMovieProvider = StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final ActorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorByMovieNotifier(getActors: ActorsRepository.getActorsByMovie);
});


typedef GetActorsCallback = Future<List<Actor>> Function(String movieID);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  
  final GetActorsCallback getActors;

  ActorByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActor(String movieId) async {
    if (state[movieId] != null) return;

    print('-- realizando petición HTTP de los actores de la película');

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
