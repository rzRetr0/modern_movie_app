import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/tv_details.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final bool hasReachedMax;

  const MovieLoaded({
    required this.movies,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [movies, hasReachedMax];
}

class MovieSearchLoaded extends MovieState {
  final List<Movie> movies;
  final bool hasReachedMax;

  const MovieSearchLoaded({
    required this.movies,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [movies, hasReachedMax];
}

class TvSearchLoaded extends MovieState {
  final List<Movie> tvShows;
  final bool hasReachedMax;

  const TvSearchLoaded({
    required this.tvShows,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [tvShows, hasReachedMax];
}

class CombinedSearchLoaded extends MovieState {
  final List<Movie> movies;
  final List<Movie> tvShows;
  final bool hasReachedMax;

  const CombinedSearchLoaded({
    required this.movies,
    required this.tvShows,
    this.hasReachedMax = false,
  });

  // Combined list of all results
  List<Movie> get allResults => [...movies, ...tvShows];

  @override
  List<Object?> get props => [movies, tvShows, hasReachedMax];
}

class MovieDetailsLoaded extends MovieState {
  final MovieDetails movieDetails;

  const MovieDetailsLoaded(this.movieDetails);

  @override
  List<Object?> get props => [movieDetails];
}

class TvDetailsLoaded extends MovieState {
  final TvDetails tvDetails;

  const TvDetailsLoaded(this.tvDetails);

  @override
  List<Object?> get props => [tvDetails];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class SeasonEpisodesLoading extends MovieState {
  final int tvId;
  final int seasonNumber;
  const SeasonEpisodesLoading(this.tvId, this.seasonNumber);
  @override
  List<Object?> get props => [tvId, seasonNumber];
}

class SeasonEpisodesLoaded extends MovieState {
  final int tvId;
  final int seasonNumber;
  final dynamic season; // Should be SeasonModel
  const SeasonEpisodesLoaded({required this.tvId, required this.seasonNumber, required this.season});
  @override
  List<Object?> get props => [tvId, seasonNumber, season];
}


