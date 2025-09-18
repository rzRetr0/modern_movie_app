// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) => EpisodeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      episodeNumber: (json['episodeNumber'] as num).toInt(),
      airDate: json['airDate'] as String?,
      overview: json['overview'] as String?,
      stillPath: json['stillPath'] as String?,
    );

Map<String, dynamic> _$EpisodeModelToJson(EpisodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'episodeNumber': instance.episodeNumber,
      'airDate': instance.airDate,
      'overview': instance.overview,
      'stillPath': instance.stillPath,
    };
