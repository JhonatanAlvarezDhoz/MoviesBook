import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/config/constants/environment.dart';
import 'package:trending_movies/presentation/providers/movies/movies_providers.dart';

class HomeScreen extends StatelessWidget {
  // name of page for goRouter
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    return ListView.builder(
        itemCount: nowPlayingMovies.length,
        itemBuilder: (context, index) {
          final movie = nowPlayingMovies[index];
          return ListTile(
            title: Text(movie.title),
          );
        });
  }
}
