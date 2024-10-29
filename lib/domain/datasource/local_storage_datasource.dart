import 'package:trending_movies/domain/entities/movie.dart';

abstract class LocalStorageDataSource {
  Future<void> toggleFavorites(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadMovie({int limit = 10, offset = 0});
}
