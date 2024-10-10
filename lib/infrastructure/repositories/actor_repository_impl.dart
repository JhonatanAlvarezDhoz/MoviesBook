import 'package:trending_movies/domain/datasource/actors_datasource.dart';
import 'package:trending_movies/domain/entities/actor.dart';
import 'package:trending_movies/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorRepositoryImpl({required this.actorsDatasource});

  @override
  Future<List<Actor>> getActorsByMovie(String moviId) {
    return actorsDatasource.getActorsByMovie(moviId);
  }
}
