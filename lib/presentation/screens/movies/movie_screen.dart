import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trending_movies/config/helpers/helpers.dart';
import 'package:trending_movies/config/theme/theme_colors.dart';
import 'package:trending_movies/domain/entities/movie.dart';
import 'package:trending_movies/presentation/providers/providers.dart';
import 'package:trending_movies/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:trending_movies/presentation/widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId,
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieDetailsProvider.notifier).loadMovie(movieId: widget.movieId);
    ref
        .read(actorsByMovieProvider.notifier)
        .loadActors(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieDetailsProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return _InfoMovie(
              movie: movie,
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}

class _InfoMovie extends ConsumerWidget {
  final Movie movie;
  const _InfoMovie({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    final overView = Helper.splitOverView(text: movie.overview, limit: 272);

    final isDivide = overView['isDivide'];
    final firstPart = overView['firstPart'];
    final secondPart = overView['secondPart'];

    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movie.id.toString()] == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final actors = actorsByMovie[movie.id.toString()];

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.223,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: size.width * 0.3,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.network(movie.posterPath),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: (size.width - 20) * 0.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: textStyle.titleLarge,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          child: Text(
                            textAlign: TextAlign.justify,
                            firstPart,
                            style: textStyle.bodySmall,
                            maxLines: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isDivide)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                textAlign: TextAlign.justify,
                secondPart,
                style: textStyle.bodySmall,
                maxLines: 20,
              ),
            ),
          _Rated(movie: movie, textStyle: textStyle),
          Chips(movie: movie),
          const Padding(
              padding: EdgeInsets.only(top: 10, left: 15),
              child: Text("Actores",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ThemeColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ))),
          Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: actors!.length,
                itemBuilder: (context, index) {
                  return FlipCard(
                    index: index,
                    actors: actors,
                  );
                }),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class Chips extends StatelessWidget {
  final Movie movie;
  const Chips({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        children: [
          ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 15),
                child: Chip(
                    backgroundColor: Helper.getGenereColor(gender),
                    side: BorderSide(color: Helper.getGenereColor(gender)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    label: Text(
                      gender,
                      style: const TextStyle(
                          color: ThemeColors.white,
                          fontWeight: FontWeight.w800),
                    )),
              ))
        ],
      ),
    );
  }
}

class _Rated extends StatelessWidget {
  const _Rated({
    required this.movie,
    required this.textStyle,
  });

  final Movie movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "Popularidad",
                maxLines: 2,
                style: textStyle.titleSmall,
              ),
              const SizedBox(width: 65),
              Text(
                FormatNumber.number(movie.popularity),
                maxLines: 2,
                style: textStyle.titleSmall,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Promdeio de votos",
                maxLines: 2,
                style: textStyle.titleSmall,
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.star_half_outlined,
                color: Color.fromARGB(255, 212, 193, 28),
              ),
              Text(
                textAlign: TextAlign.center,
                FormatNumber.number(movie.voteAverage),
                maxLines: 2,
                style: textStyle.bodyMedium
                    ?.copyWith(color: const Color.fromARGB(255, 212, 193, 28)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: ThemeColors.blackColor,
      expandedHeight: size.height * 0.7,
      foregroundColor: ThemeColors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie);

            // invalida el estado del provider y por eso lo vuelve hacer
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFuture.when(
            data: (isFavorite) => isFavorite
                ? const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite_border),
            error: (error, stackTrace) => throw UnimplementedError(),
            loading: () => const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
      shadowColor: Colors.red,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 18, color: ThemeColors.white),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox.shrink();

                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradients(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black87,
              ],
              stops: [0.7, 1.0],
            ),
            const _CustomGradients(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
                stops: [
                  0.0,
                  0.25,
                ]),
            const _CustomGradients(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
                stops: [
                  0.0,
                  0.25,
                ])
          ],
        ),
      ),
    );
  }
}

class _CustomGradients extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;
  final List<double> stops;
  const _CustomGradients(
      {required this.begin,
      required this.end,
      required this.colors,
      required this.stops});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, colors: colors, stops: stops),
        ),
      ),
    );
  }
}
