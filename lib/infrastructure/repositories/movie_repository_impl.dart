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

  @override
  Future<List<Movie>> getPopularMovie({int page = 1}) {
    return moviesDatasource.getPopularMovie(page: page);
  }

  @override
  Future<List<Movie>> getTopRatedMovie({int page = 1}) {
    return moviesDatasource.getTopRatedMovie(page: page);
  }

  @override
  Future<List<Movie>> getUpcomingMovie({int page = 1}) {
    return moviesDatasource.getUpcomingMovie(page: page);
  }

  @override
  Future<Movie> getMovieById({String? movieId}) {
    return moviesDatasource.getMovieById(movieId: movieId!);
  }

  @override
  Future<List<Movie>> searchMovies({String query = ""}) {
    return moviesDatasource.searchMovies(query: query);
  }
}
