import 'package:dio/dio.dart';
import 'package:trending_movies/config/constants/environment.dart';
import 'package:trending_movies/domain/datasource/actors_datasource.dart';
import 'package:trending_movies/domain/entities/actor.dart';
import 'package:trending_movies/infrastructure/mappers/actor_mapper.dart';
import 'package:trending_movies/infrastructure/models/cast_moviedb.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.apiKeyTMDB,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String moviId) async {
    final response = await dio.get('/movie/$moviId/credits');

    final castDbResponse = CastMovieDb.fromJson(response.data);

    final List<Actor> actors = castDbResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
