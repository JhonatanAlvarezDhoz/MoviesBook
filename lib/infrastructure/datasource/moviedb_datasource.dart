import 'package:dio/dio.dart';
import 'package:trending_movies/config/constants/environment.dart';
import 'package:trending_movies/domain/datasource/movies_datasource.dart';
import 'package:trending_movies/domain/entities/movie.dart';
import 'package:trending_movies/infrastructure/mappers/movie_mapper.dart';
import 'package:trending_movies/infrastructure/models/moviedb_response.dart';

class MovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.apiKeyTMDB,
        'language': 'es-MX'
      }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    final MovieDbResponse movieDbResponse =
        MovieDbResponse.fromJson(response.data);
    //where() if it's true continius
    final List<Movie> movies = movieDbResponse.results!
        .where((movieDb) => movieDb.backdropPath != null)
        .map((movie) => MovieMapper.movieDbToEntity(movie))
        .toList();

    return movies;
  }
}
