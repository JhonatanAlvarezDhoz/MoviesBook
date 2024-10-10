import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/domain/entities/actor.dart';
import 'package:trending_movies/presentation/providers/actors/actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsMapNotifier, Map<String, List<Actor>>>((ref) {
  final getActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;

  return ActorsMapNotifier(getActors: getActors);
});

typedef GetActorCallBac = Future<List<Actor>> Function(String movieId);

//provider
class ActorsMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorCallBac getActors;
  ActorsMapNotifier({required this.getActors}) : super({});

  Future<void> loadActors({required String movieId}) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
