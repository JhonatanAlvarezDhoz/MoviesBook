import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:trending_movies/presentation/widgets/movies/movie_masonry.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {
  bool isLoading = false;
  bool isLastPage = false;
  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = true;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoriteMoviesProvider).values.toList();

    if (movies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              FadeInDown(
                child: Icon(
                  Icons.favorite_outline_outlined,
                  size: 60,
                  color: colors.primary,
                ),
              ),
              Text("Upsss...",
                  style: TextStyle(fontSize: 30, color: colors.primary)),
              const Text("No cuentas con peliculas favoritas",
                  style: TextStyle(fontSize: 20, color: Colors.black45)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Favoritos"),
        ),
        body: MovieMasonry(
          loadNextPage: loadNextPage,
          movies: movies,
        ));
  }
}
