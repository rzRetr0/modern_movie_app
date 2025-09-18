// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonModel _$SeasonModelFromJson(Map<String, dynamic> json) => SeasonModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      seasonNumber: (json['seasonNumber'] as num).toInt(),
      episodeCount: (json['episodeCount'] as num?)?.toInt(),
      airDate: json['airDate'] as String?,
      posterPath: json['posterPath'] as String?,
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeasonModelToJson(SeasonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seasonNumber': instance.seasonNumber,
      'episodeCount': instance.episodeCount,
      'airDate': instance.airDate,
      'posterPath': instance.posterPath,
      'episodes': instance.episodes,
    };
