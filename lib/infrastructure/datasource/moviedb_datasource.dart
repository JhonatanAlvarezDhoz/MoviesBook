import 'package:dio/dio.dart';
import 'package:trending_movies/config/constants/environment.dart';
import 'package:trending_movies/domain/datasource/movies_datasource.dart';
import 'package:trending_movies/domain/entities/movie.dart';
import 'package:trending_movies/infrastructure/mappers/movie_mapper.dart';
import 'package:trending_movies/infrastructure/models/movie_details_models.dart';
import 'package:trending_movies/infrastructure/models/moviedb_response.dart';

class MovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.apiKeyTMDB,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final MovieDbResponse movieDbResponse = MovieDbResponse.fromJson(json);
    //where() if it's true continius
    final List<Movie> movies = movieDbResponse.results!
        .where((movieDb) => movieDb.backdropPath != null)
        .map((movie) => MovieMapper.movieDbToEntity(movie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovie({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRatedMovie({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcomingMovie({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById({String? movieId}) async {
    final response = await dio.get('/movie/$movieId');

    if (response.statusCode != 200) {
      throw Exception("Movie whit id: $movieId not found");
    }
    final movieDbDetails = MovieDbDetails.fromJson(response.data);

    final movie = MovieMapper.movieDbDetailsToEntity(movieDbDetails);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies({String query = ""}) async {
    final response = await dio.get(
      '/search/movie',
      queryParameters: {"query": query},
    );

    if (response.statusCode != 200) {
      throw Exception("Movie whit id: $query found");
    }

    return _jsonToMovies(response.data);
  }
}
