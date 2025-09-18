import 'package:equatable/equatable.dart';
import 'season.dart';

class TvDetails extends Equatable {
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
  final List<Season>? seasons;

  const TvDetails({
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

  @override
  List<Object?> get props => [id, name, overview, posterPath, backdropPath, voteAverage, voteCount, firstAirDate, genres, originalLanguage, originalName, popularity, numberOfSeasons, numberOfEpisodes, status, imdbId, seasons];
}
