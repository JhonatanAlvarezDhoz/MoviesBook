import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trending_movies/domain/datasource/local_storage_datasource.dart';
import 'package:trending_movies/domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDataSource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final directory = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: directory.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final Movie? isMovieFavotite =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isMovieFavotite != null;
  }

  @override
  Future<List<Movie>> loadMovie({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorites(Movie movie) async {
    final isar = await db;

    final Movie? favotiteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favotiteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favotiteMovie.isarId!));
      return;
    }
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
