import 'package:trending_movies/domain/entities/movie.dart';
import 'package:trending_movies/domain/datasource/movies_datasource.dart';
import 'package:trending_movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource moviesDatasource;

  MoviesRepositoryImpl({required this.moviesDatasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDatasource.getNowPlaying(page: page);
  }
}
