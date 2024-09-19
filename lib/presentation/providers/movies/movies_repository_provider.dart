// class MoviesRepositoryProvider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/infrastructure/datasource/moviedb_datasource.dart';
import 'package:trending_movies/infrastructure/repositories/movie_repository_impl.dart';

// this repository is not mutable, it's reed only
final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(moviesDatasource: MovieDbDatasource());
});
