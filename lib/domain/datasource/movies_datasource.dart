import 'package:trending_movies/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopularMovie({int page = 1});

  Future<List<Movie>> getUpcomingMovie({int page = 1});

  Future<List<Movie>> getTopRatedMovie({int page = 1});

  Future<Movie> getMovieById({String movieId});

  Future<List<Movie>> searchMovies({String query});
}
