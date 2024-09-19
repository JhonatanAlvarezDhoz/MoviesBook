import 'package:trending_movies/domain/entities/movie.dart';
import 'package:trending_movies/infrastructure/models/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDb movieDb) => Movie(
      adult: movieDb.adult ?? false,
      backdropPath: (movieDb.backdropPath != null)
          ? "https://image.tmdb.org/t/p/w500${movieDb.backdropPath}"
          : "https://asean.org/wp-content/uploads/2022/07/No-Image-Placeholder.svg.png",
      genreIds: movieDb.genreIds!.map((movie) => movie.toString()).toList(),
      id: movieDb.id!,
      originalLanguage: movieDb.originalLanguage ?? "",
      originalTitle: movieDb.originalTitle ?? "",
      overview: movieDb.overview ?? "",
      popularity: movieDb.popularity ?? 0.0,
      posterPath: (movieDb.posterPath != null)
          ? "https://image.tmdb.org/t/p/w500${movieDb.posterPath}"
          : "https://asean.org/wp-content/uploads/2022/07/No-Image-Placeholder.svg.png",
      releaseDate: movieDb.releaseDate ?? DateTime(2024),
      title: movieDb.title ?? "",
      video: movieDb.video ?? false,
      voteAverage: movieDb.voteAverage ?? 0.0,
      voteCount: movieDb.voteCount ?? 0);
}
