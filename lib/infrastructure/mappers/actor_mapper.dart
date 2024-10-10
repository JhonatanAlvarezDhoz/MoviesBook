import 'package:trending_movies/domain/entities/actor.dart';
import 'package:trending_movies/infrastructure/models/cast_moviedb.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? "https://image.tmdb.org/t/p/w500${cast.profilePath}"
            : "https://asean.org/wp-content/uploads/2022/07/No-Image-Placeholder.svg.png",
        character: cast.character ?? "",
      );
}
