import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final int episodeNumber;
  final String? airDate;
  final String? overview;
  final String? stillPath;

  const Episode({
    required this.id,
    required this.name,
    required this.episodeNumber,
    this.airDate,
    this.overview,
    this.stillPath,
  });

  @override
  List<Object?> get props => [id, name, episodeNumber, airDate, overview, stillPath];
}
