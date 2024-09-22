import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/domain/entities/movie.dart';
import 'package:trending_movies/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //reference to movieRepositoryProvider
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //reference to movieRepositoryProvide, it's useCase
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopularMovie;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //reference to movieRepositoryProvide, it's useCase
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRatedMovie;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //reference to movieRepositoryProvide, it's useCase
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcomingMovie;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// especific fuction tha i need
typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    //change state
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
