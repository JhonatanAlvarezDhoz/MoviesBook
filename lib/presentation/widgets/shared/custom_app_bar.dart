import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trending_movies/presentation/delegates/search_movie_delegate.dart';
import 'package:trending_movies/presentation/providers/providers.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        bottom: false,
        child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: constraints.maxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50,
                  width: 40,
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(
                    height: 20,
                    width: 270,
                    child: Image.asset("assets/images/title.png")),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      final movieRepository = ref.read(movieRepositoryProvider);
                      showSearch(
                        context: context,
                        delegate: SearchMovieDelegate(
                            searchMovie: movieRepository.searchMovies),
                      );
                    },
                    child: const Icon(Icons.search))
              ],
            ),
          );
        }));
  }
}
