import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:trending_movies/config/helpers/format_number.dart';
import 'package:trending_movies/domain/entities/movie.dart';

class ListviewMovies extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const ListviewMovies(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<ListviewMovies> createState() => _ListviewMoviesState();
}

class _ListviewMoviesState extends State<ListviewMovies> {
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _TitleAndSubTitle(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.movies.length,
                  itemBuilder: (context, index) {
                    return FadeInRight(
                      child: _MovieCard(
                        movie: widget.movies[index],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 150,
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
          const SizedBox(height: 5),
          // title
          SizedBox(
              width: 150,
              child: Text(
                movie.title,
                maxLines: 1,
                style: textStyle.titleSmall,
                overflow: TextOverflow.ellipsis,
              )),

          SizedBox(
            width: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.star_half_outlined,
                  color: Color.fromARGB(255, 212, 193, 28),
                ),
                const SizedBox(height: 5),
                Text(
                  FormatNumber.number(movie.voteAverage),
                  maxLines: 2,
                  style: textStyle.bodyMedium?.copyWith(
                      color: const Color.fromARGB(255, 212, 193, 28)),
                ),
                const Spacer(),
                Text(
                  FormatNumber.number(movie.popularity),
                  maxLines: 2,
                  style: textStyle.titleSmall,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TitleAndSubTitle extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _TitleAndSubTitle({
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (subTitle != null)
            FilledButton(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!)),
        ],
      ),
    );
  }
}
