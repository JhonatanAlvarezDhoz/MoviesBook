import 'package:trending_movies/domain/entities/movie.dart';
import 'package:trending_movies/domain/datasource/local_storage_datasource.dart';
import 'package:trending_movies/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl({required this.dataSource});
  @override
  Future<bool> isMovieFavorite(int movieId) {
    return dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovie({int limit = 10, offset = 0}) {
    return dataSource.loadMovie(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorites(Movie movie) {
    return dataSource.toggleFavorites(movie);
  }
}
