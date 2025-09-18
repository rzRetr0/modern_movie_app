import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/tv_details.dart';
import 'season_model.dart';

part 'tv_details_model.g.dart';

@JsonSerializable()
class TvDetailsModel {
  final int id;
  final String name;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final String? firstAirDate;
  final List<dynamic>? genres;
  final String? originalLanguage;
  final String? originalName;
  final double? popularity;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final String? status;
  final String? imdbId;
  final List<SeasonModel>? seasons;

  const TvDetailsModel({
    required this.id,
    required this.name,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.firstAirDate,
    this.genres,
    this.originalLanguage,
    this.originalName,
    this.popularity,
    this.numberOfSeasons,
    this.numberOfEpisodes,
  this.status,
  this.imdbId,
    this.seasons,
  });

  TvDetails toEntity() => TvDetails(
    id: id,
    name: name,
    overview: overview,
    posterPath: posterPath,
    backdropPath: backdropPath,
    voteAverage: voteAverage,
    voteCount: voteCount,
    firstAirDate: firstAirDate,
    genres: genres,
    originalLanguage: originalLanguage,
    originalName: originalName,
    popularity: popularity,
    numberOfSeasons: numberOfSeasons,
    numberOfEpisodes: numberOfEpisodes,
    status: status,
    imdbId: imdbId,
    seasons: seasons?.map((e) => e.toEntity()).toList(),
  );

  factory TvDetailsModel.fromJson(Map<String, dynamic> json) => TvDetailsModel(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String,
    overview: json['overview'] as String?,
    posterPath: json['poster_path'] as String?,
    backdropPath: json['backdrop_path'] as String?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: (json['vote_count'] as num?)?.toInt(),
    firstAirDate: json['first_air_date'] as String?,
    genres: json['genres'] as List<dynamic>?,
    originalLanguage: json['original_language'] as String?,
    originalName: json['original_name'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    numberOfSeasons: (json['numberOfSeasons'] as num?)?.toInt(),
    numberOfEpisodes: (json['numberOfEpisodes'] as num?)?.toInt(),
  status: json['status'] as String?,
  imdbId: json['imdb_id'] as String?,
  seasons: (json['seasons'] as List<dynamic>?)?.map((e) => SeasonModel.fromJson(e as Map<String, dynamic>)).toList(),
  );
  Map<String, dynamic> toJson() => _$TvDetailsModelToJson(this);
}
