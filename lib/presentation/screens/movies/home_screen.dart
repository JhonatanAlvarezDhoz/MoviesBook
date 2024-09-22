import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trending_movies/presentation/providers/providers.dart';
import 'package:trending_movies/presentation/widgets/shared/glass_morphing.dart';
import 'package:trending_movies/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  // name of page for goRouter`
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: _HomeView(), bottomNavigationBar: CustomNavigationBar());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  bool _showOverlay = true;

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();

    // Iniciar el retraso para ocultar la superposición después del tiempo
    _startDelay();
  }

  void _startDelay() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _showOverlay = false; // Ocultar el overlay después del delay
    });
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: [
          // CustomScrollView se muestra inmediatamente
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                floating: true,
                elevation: 1,
                flexibleSpace: FlexibleSpaceBar(
                  title: CustomAppBar(),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(
                    children: [
                      MoviesSlideShow(movies: slideShowMovies),
                      ListviewMovies(
                        movies: nowPlayingMovies,
                        title: "En cines",
                        subTitle: "Lunes 20",
                        loadNextPage: () => ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      ListviewMovies(
                        movies: popularMovies,
                        title: "Populares",
                        loadNextPage: () => ref
                            .read(popularMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      ListviewMovies(
                        movies: upComingMovies,
                        title: "Proximamente",
                        loadNextPage: () => ref
                            .read(upComingMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      ListviewMovies(
                        movies: topRatedMovies,
                        title: "Mejor calificadas",
                        loadNextPage: () => ref
                            .read(topRatedMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                    ],
                  );
                }, childCount: 1),
              ),
            ],
          ),
          // Superposición de GlassMorphism que desaparece después del delay
          if (_showOverlay)
            Positioned.fill(
              child: GlassMorphism(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              ),
            ),
        ],
      );
    });
  }
}
