import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class GetPopularMoviesEvent extends MovieEvent {
  final int page;

  const GetPopularMoviesEvent({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class GetTopRatedMoviesEvent extends MovieEvent {
  final int page;

  const GetTopRatedMoviesEvent({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class GetNowPlayingMoviesEvent extends MovieEvent {
  final int page;

  const GetNowPlayingMoviesEvent({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class GetMovieDetailsEvent extends MovieEvent {
  final int movieId;

  const GetMovieDetailsEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class GetTvDetailsEvent extends MovieEvent {
  final int tvId;

  const GetTvDetailsEvent(this.tvId);

  @override
  List<Object?> get props => [tvId];
}

class SearchMoviesEvent extends MovieEvent {
  final String query;
  final int page;

  const SearchMoviesEvent({required this.query, this.page = 1});

  @override
  List<Object?> get props => [query, page];
}

class SearchTvEvent extends MovieEvent {
  final String query;
  final int page;

  const SearchTvEvent({required this.query, this.page = 1});

  @override
  List<Object?> get props => [query, page];
}

class SearchCombinedEvent extends MovieEvent {
  final String query;
  final int page;

  const SearchCombinedEvent({required this.query, this.page = 1});

  @override
  List<Object?> get props => [query, page];
}

class LoadSeasonEpisodesEvent extends MovieEvent {
  final int tvId;
  final int seasonNumber;

  const LoadSeasonEpisodesEvent({required this.tvId, required this.seasonNumber});

  @override
  List<Object?> get props => [tvId, seasonNumber];
}


