import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/domain/entities/movie.dart';
import 'package:trending_movies/presentation/providers/providers.dart';

final movieDetailsProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider).getMovieById;

  return MovieMapNotifier(getMovie);
});

typedef GetMovieCallBac = Future<Movie> Function({String movieId});

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBac getMovieCallBac;
  MovieMapNotifier(this.getMovieCallBac) : super({});

  Future<void> loadMovie({required String movieId}) async {
    if (state[movieId] != null) return;

    final movie = await getMovieCallBac(movieId: movieId);

    state = {...state, movieId: movie};
  }
}
