import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trending_movies/config/helpers/format_number.dart';
import 'package:trending_movies/domain/entities/movie.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function({String query});

class SearchMovieDelegate extends SearchDelegate {
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debouceTimer;

  final SearchMoviesCallBack searchMovie;
  List<Movie>? initialMovies;

  SearchMovieDelegate(
      {
      //   super.searchFieldLabel,
      // super.searchFieldStyle,
      // super.searchFieldDecorationTheme,
      // super.keyboardType,
      super.textInputAction,
      required this.searchMovie,
      this.initialMovies});

  @override
  String get searchFieldLabel => "Buscar Pelicula";

  void _onQueryChange(String query) {
    if (_debouceTimer?.isActive ?? false) _debouceTimer!.cancel();

    _debouceTimer = Timer(const Duration(milliseconds: 700), () async {
      if (query.isEmpty) {
        debounceMovies.add([]);
        return;
      }
      final movies = await searchMovie(query: query);
      initialMovies = movies;
      debounceMovies.add(movies);
    });
  }

  void clearStrems() {
    debounceMovies.close();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        FadeInRight(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.close),
            ),
          ),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStrems();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultAndSugestion();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return buildResultAndSugestion();
  }

  Widget buildResultAndSugestion() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieSearchItem(
              movie: movie,
            );
          },
        );
      },
    );
  }
}

class MovieSearchItem extends StatelessWidget {
  final Movie movie;
  const MovieSearchItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${movie.id}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  errorBuilder: (context, error, stackTrace) {
                    log(error.toString());
                    return Image.network(
                        "https://asean.org/wp-content/uploads/2022/07/No-Image-Placeholder.svg.png");
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black12));
                    }

                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                    maxLines: 2,
                  ),
                  (movie.overview.length > 90)
                      ? Text('${movie.overview.substring(0, 90)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade700,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        FormatNumber.number(movie.voteAverage, 1),
                        style: TextStyle(
                          color: Colors.yellow.shade900,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
