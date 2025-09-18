import '../../domain/entities/episode.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/episode.dart';

part 'episode_model.g.dart';


@JsonSerializable()
class EpisodeModel {
  final int id;
  final String name;
  final int episodeNumber;
  final String? airDate;
  final String? overview;
  final String? stillPath;

  const EpisodeModel({
    required this.id,
    required this.name,
    required this.episodeNumber,
    this.airDate,
    this.overview,
    this.stillPath,
  });

  Episode toEntity() => Episode(
    id: id,
    name: name,
    episodeNumber: episodeNumber,
    airDate: airDate,
    overview: overview,
    stillPath: stillPath,
  );

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
    id: (json['id'] as num?)?.toInt() ?? 0,
    name: json['name'] as String? ?? '',
    episodeNumber: (json['episode_number'] ?? json['episodeNumber']) is num
        ? (json['episode_number'] ?? json['episodeNumber'] as num).toInt()
        : int.tryParse((json['episode_number'] ?? json['episodeNumber'])?.toString() ?? '') ?? 0,
    airDate: json['air_date'] as String? ?? json['airDate'] as String?,
    overview: json['overview'] as String?,
    stillPath: json['still_path'] as String? ?? json['stillPath'] as String?,
  );
  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);
}
