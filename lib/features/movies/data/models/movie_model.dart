import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Movie {
  const MovieModel({
    required int id,
    required String title,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    bool? adult,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    double? popularity,
    bool? video,
  }) : super(
    id: id,
    title: title,
    overview: overview,
    posterPath: posterPath,
    backdropPath: backdropPath,
    voteAverage: voteAverage,
    voteCount: voteCount,
    releaseDate: releaseDate,
    genreIds: genreIds,
    adult: adult,
    originalLanguage: originalLanguage,
    originalTitle: originalTitle,
    popularity: popularity,
    video: video,
  );


  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Support both movie and TV show fields from TMDB
    return MovieModel(
      id: (json['id'] as num).toInt(),
      title: (json['title'] ?? json['name'] ?? '') as String,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      releaseDate: (json['release_date'] ?? json['first_air_date']) as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
      adult: json['adult'] as bool?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: (json['original_title'] ?? json['original_name']) as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      video: json['video'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  factory MovieModel.fromEntity(Movie movie) {
    return MovieModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      releaseDate: movie.releaseDate,
      genreIds: movie.genreIds,
      adult: movie.adult,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      popularity: movie.popularity,
      video: movie.video,
    );
  }
}
