import 'package:json_annotation/json_annotation.dart';
import 'episode_model.dart';
import '../../domain/entities/season.dart';

part 'season_model.g.dart';


@JsonSerializable()
class SeasonModel {
  final int id;
  final String name;
  final int seasonNumber;
  final int? episodeCount;
  final String? airDate;
  final String? posterPath;
  final List<EpisodeModel>? episodes;

  SeasonModel({
    required this.id,
    required this.name,
    required this.seasonNumber,
    this.episodeCount,
    this.airDate,
    this.posterPath,
    this.episodes,
  });

  Season toEntity() => Season(
    id: id,
    name: name,
    seasonNumber: seasonNumber,
    episodeCount: episodeCount,
    airDate: airDate,
    posterPath: posterPath,
  episodes: episodes?.map((e) => e.toEntity()).toList(),
  );

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
    id: (json['id'] as num?)?.toInt() ?? 0,
    name: json['name'] as String? ?? '',
    seasonNumber: (json['season_number'] ?? json['seasonNumber']) is num
        ? (json['season_number'] ?? json['seasonNumber'] as num).toInt()
        : int.tryParse((json['season_number'] ?? json['seasonNumber'])?.toString() ?? '') ?? 0,
    episodeCount: (json['episode_count'] ?? json['episodeCount']) is num
        ? (json['episode_count'] ?? json['episodeCount'] as num).toInt()
        : (json['episode_count'] ?? json['episodeCount']) == null
            ? null
            : int.tryParse((json['episode_count'] ?? json['episodeCount']).toString()),
    airDate: json['air_date'] as String? ?? json['airDate'] as String?,
    posterPath: json['poster_path'] as String? ?? json['posterPath'] as String?,
    episodes: (json['episodes'] as List?)?.map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>)).toList(),
  );
  Map<String, dynamic> toJson() => _$SeasonModelToJson(this);
}
