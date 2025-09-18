import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/tv_details.dart';
import '../../domain/entities/season.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      return await remoteDataSource.getPopularMovies(page: page);
    } catch (e) {
      throw Exception('Failed to get popular movies: $e');
    }
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    try {
      return await remoteDataSource.getTopRatedMovies(page: page);
    } catch (e) {
      throw Exception('Failed to get top rated movies: $e');
    }
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    try {
      return await remoteDataSource.getNowPlayingMovies(page: page);
    } catch (e) {
      throw Exception('Failed to get now playing movies: $e');
    }
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    try {
      return await remoteDataSource.getMovieDetails(movieId);
    } catch (e) {
      throw Exception('Failed to get movie details: $e');
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    try {
      return await remoteDataSource.searchMovies(query, page: page);
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }

  @override
  Future<List<Movie>> searchTvShows(String query, {int page = 1}) async {
    try {
      return await remoteDataSource.searchTvShows(query, page: page);
    } catch (e) {
      throw Exception('Failed to search TV shows: $e');
    }
  }

  @override
  Future<TvDetails> getTvDetails(int tvId) async {
    try {
  final model = await remoteDataSource.getTvDetails(tvId);
  return model.toEntity();
    } catch (e) {
      throw Exception('Failed to get TV details: $e');
    }
  }

  @override
  Future<Season> getSeasonDetails(int tvId, int seasonNumber) async {
    try {
      final model = await remoteDataSource.getSeasonDetails(tvId, seasonNumber);
      return model.toEntity();
    } catch (e) {
      throw Exception('Failed to get season details: $e');
    }
  }
}
