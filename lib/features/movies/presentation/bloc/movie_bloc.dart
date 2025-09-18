import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';
import '../../domain/usecases/get_now_playing_movies.dart';
import '../../domain/usecases/get_movie_details.dart';
import '../../domain/usecases/search_movies.dart';
import '../../domain/usecases/get_tv_details.dart';
import '../../domain/usecases/search_tv_shows.dart';
import '../../domain/usecases/get_season_details.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetMovieDetails getMovieDetails;
  final GetTvDetails getTvDetails;
  final SearchMovies searchMovies;
  final SearchTvShows searchTvShows;
  final GetSeasonDetails getSeasonDetails;

  List<Movie> _movies = [];
  List<Movie> _tvShows = [];
  int _currentPage = 1;
  int _currentTvPage = 1;
  bool _hasReachedMax = false;
  bool _hasReachedTvMax = false;

  MovieBloc({
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getNowPlayingMovies,
    required this.getMovieDetails,
    required this.getTvDetails,
    required this.searchMovies,
    required this.searchTvShows,
    required this.getSeasonDetails,
  }) : super(MovieInitial()) {
    on<GetPopularMoviesEvent>(_onGetPopularMovies);
    on<GetTopRatedMoviesEvent>(_onGetTopRatedMovies);
    on<GetNowPlayingMoviesEvent>(_onGetNowPlayingMovies);
    on<GetMovieDetailsEvent>(_onGetMovieDetails);
    on<GetTvDetailsEvent>(_onGetTvDetails);
    on<SearchMoviesEvent>(_onSearchMovies);
    on<SearchTvEvent>(_onSearchTv);
    on<SearchCombinedEvent>(_onSearchCombined);
    on<LoadSeasonEpisodesEvent>(_onLoadSeasonEpisodes);
  }

  Future<void> _onGetTvDetails(
    GetTvDetailsEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    try {
      final tvDetails = await getTvDetails(event.tvId);
      emit(TvDetailsLoaded(tvDetails));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onGetPopularMovies(
    GetPopularMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.page == 1) {
      _movies = [];
      _hasReachedMax = false;
      _currentPage = 1;
    }

    if (_hasReachedMax) return;

    emit(MovieLoading());

    try {
      final movies = await getPopularMovies(page: event.page);
      
      if (event.page == 1) {
        _movies = movies;
      } else {
        _movies.addAll(movies);
      }
      _currentPage = event.page;
      _hasReachedMax = movies.length < 20; // Assuming 20 movies per page

      emit(MovieLoaded(
        movies: List.from(_movies),
        hasReachedMax: _hasReachedMax,
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onGetTopRatedMovies(
    GetTopRatedMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.page == 1) {
      _movies = [];
      _hasReachedMax = false;
      _currentPage = 1;
    }

    if (_hasReachedMax) return;

    emit(MovieLoading());

    try {
      final movies = await getTopRatedMovies(page: event.page);
      
      if (event.page == 1) {
        _movies = movies;
      } else {
        _movies.addAll(movies);
      }
      _currentPage = event.page;
      _hasReachedMax = movies.length < 20;

      emit(MovieLoaded(
        movies: List.from(_movies),
        hasReachedMax: _hasReachedMax,
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onGetNowPlayingMovies(
    GetNowPlayingMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.page == 1) {
      _movies = [];
      _hasReachedMax = false;
      _currentPage = 1;
    }

    if (_hasReachedMax) return;

    emit(MovieLoading());

    try {
      final movies = await getNowPlayingMovies(page: event.page);
      
      if (event.page == 1) {
        _movies = movies;
      } else {
        _movies.addAll(movies);
      }
      _currentPage = event.page;
      _hasReachedMax = movies.length < 20;

      emit(MovieLoaded(
        movies: List.from(_movies),
        hasReachedMax: _hasReachedMax,
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onGetMovieDetails(
    GetMovieDetailsEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());

    try {
      final movieDetails = await getMovieDetails(event.movieId);
      emit(MovieDetailsLoaded(movieDetails));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.page == 1) {
      _movies = [];
      _hasReachedMax = false;
      _currentPage = 1;
    }

    if (_hasReachedMax) return;

    emit(MovieLoading());

    try {
      final movies = await searchMovies(event.query, page: event.page);
      if (event.page == 1) {
        _movies = movies;
      } else {
        _movies.addAll(movies);
      }
      _currentPage = event.page;
      _hasReachedMax = movies.length < 20;

      emit(MovieSearchLoaded(
        movies: List.from(_movies),
        hasReachedMax: _hasReachedMax,
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onSearchTv(
    SearchTvEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.page == 1) {
      _tvShows = [];
      _hasReachedTvMax = false;
      _currentTvPage = 1;
    }

    if (_hasReachedTvMax) return;

    emit(MovieLoading());

    try {
      final tvShows = await searchTvShows(event.query, page: event.page);
      if (event.page == 1) {
        _tvShows = tvShows;
      } else {
        _tvShows.addAll(tvShows);
      }
      _currentTvPage = event.page;
      _hasReachedTvMax = tvShows.length < 20;

      emit(TvSearchLoaded(
        tvShows: List.from(_tvShows),
        hasReachedMax: _hasReachedTvMax,
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onSearchCombined(
    SearchCombinedEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (event.page == 1) {
      _movies = [];
      _tvShows = [];
      _hasReachedMax = false;
      _hasReachedTvMax = false;
      _currentPage = 1;
      _currentTvPage = 1;
    }

    if (_hasReachedMax && _hasReachedTvMax) return;

    emit(MovieLoading());

    try {
      // Search both movies and TV shows concurrently
      final movieResults = searchMovies(event.query, page: event.page);
      final tvResults = searchTvShows(event.query, page: event.page);

      final results = await Future.wait([movieResults, tvResults]);

      final movies = results[0] as List<Movie>;
      final tvShows = results[1] as List<Movie>;

      if (event.page == 1) {
        _movies = movies;
        _tvShows = tvShows;
      } else {
        _movies.addAll(movies);
        _tvShows.addAll(tvShows);
      }

      _currentPage = event.page;
      _currentTvPage = event.page;
      _hasReachedMax = movies.length < 20;
      _hasReachedTvMax = tvShows.length < 20;

      emit(CombinedSearchLoaded(
        movies: List.from(_movies),
        tvShows: List.from(_tvShows),
        hasReachedMax: _hasReachedMax && _hasReachedTvMax,
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onLoadSeasonEpisodes(
    LoadSeasonEpisodesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(SeasonEpisodesLoading(event.tvId, event.seasonNumber));
    try {
      final season = await getSeasonDetails(event.tvId, event.seasonNumber);
      print('[DEBUG] Loaded season: ' + season.toString());
      print('[DEBUG] Episodes: ' + (season.episodes?.map((e) => e.toString()).toList().toString() ?? 'null'));
      emit(SeasonEpisodesLoaded(tvId: event.tvId, seasonNumber: event.seasonNumber, season: season));
    } catch (e) {
      print('[DEBUG] Error loading season: ' + e.toString());
      emit(MovieError(e.toString()));
    }
  }
}
