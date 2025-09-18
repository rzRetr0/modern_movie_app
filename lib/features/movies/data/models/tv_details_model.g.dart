// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvDetailsModel _$TvDetailsModelFromJson(Map<String, dynamic> json) =>
    TvDetailsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      overview: json['overview'] as String?,
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: (json['voteCount'] as num?)?.toInt(),
      firstAirDate: json['firstAirDate'] as String?,
      genres: json['genres'] as List<dynamic>?,
      originalLanguage: json['originalLanguage'] as String?,
      originalName: json['originalName'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      numberOfSeasons: (json['numberOfSeasons'] as num?)?.toInt(),
      numberOfEpisodes: (json['numberOfEpisodes'] as num?)?.toInt(),
      status: json['status'] as String?,
      imdbId: json['imdbId'] as String?,
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeasonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvDetailsModelToJson(TvDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'posterPath': instance.posterPath,
      'backdropPath': instance.backdropPath,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
      'firstAirDate': instance.firstAirDate,
      'genres': instance.genres,
      'originalLanguage': instance.originalLanguage,
      'originalName': instance.originalName,
      'popularity': instance.popularity,
      'numberOfSeasons': instance.numberOfSeasons,
      'numberOfEpisodes': instance.numberOfEpisodes,
      'status': instance.status,
      'imdbId': instance.imdbId,
      'seasons': instance.seasons,
    };
