import '../entities/movie.dart';
import '../entities/movie_details.dart';

import '../entities/tv_details.dart';
import '../entities/season.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getTopRatedMovies({int page = 1});
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
  Future<MovieDetails> getMovieDetails(int movieId);
  Future<List<Movie>> searchMovies(String query, {int page = 1});
  Future<List<Movie>> searchTvShows(String query, {int page = 1});
  Future<TvDetails> getTvDetails(int tvId);
  Future<Season> getSeasonDetails(int tvId, int seasonNumber);
}
