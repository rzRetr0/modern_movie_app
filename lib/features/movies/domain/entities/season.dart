import 'package:equatable/equatable.dart';
import 'episode.dart';

class Season extends Equatable {
  final int id;
  final String name;
  final int seasonNumber;
  final int? episodeCount;
  final String? airDate;
  final String? posterPath;
  final List<Episode>? episodes;

  const Season({
    required this.id,
    required this.name,
    required this.seasonNumber,
    this.episodeCount,
    this.airDate,
    this.posterPath,
    this.episodes,
  });

  @override
  List<Object?> get props => [id, name, seasonNumber, episodeCount, airDate, posterPath, episodes];
}
