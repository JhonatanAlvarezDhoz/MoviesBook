import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trending_movies/infrastructure/datasource/isar_datasource.dart';
import 'package:trending_movies/infrastructure/repositories/local_storage_repository_impl.dart';

//creamos provider
final localStorageRepositoryProvider = Provider((ref) {
  //regresamos la implementacion del repository
  return LocalStorageRepositoryImpl(dataSource: IsarDatasource());
});
