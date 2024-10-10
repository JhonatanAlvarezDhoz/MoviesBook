import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/infrastructure/datasource/actor_moviedb_datasource.dart';
import 'package:trending_movies/infrastructure/repositories/actor_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(actorsDatasource: ActorMoviedbDatasource());
});
