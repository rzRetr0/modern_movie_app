import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/movie_model.dart';
import '../models/movie_details_model.dart';
import '../models/tv_details_model.dart';
import '../models/season_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<List<MovieModel>> getTopRatedMovies({int page = 1});
  Future<List<MovieModel>> getNowPlayingMovies({int page = 1});
  Future<MovieDetailsModel> getMovieDetails(int movieId);
  Future<List<MovieModel>> searchMovies(String query, {int page = 1});
  Future<List<MovieModel>> searchTvShows(String query, {int page = 1});
  Future<TvDetailsModel> getTvDetails(int tvId);
  Future<SeasonModel> getSeasonDetails(int tvId, int seasonNumber);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.popularMoviesEndpoint}',
        queryParameters: {
          'api_key': AppConstants.apiKey,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = response.data['results'];
        return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.topRatedMoviesEndpoint}',
        queryParameters: {
          'api_key': AppConstants.apiKey,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = response.data['results'];
        return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load top rated movies');
      }
    } catch (e) {
      throw Exception('Error fetching top rated movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies({int page = 1}) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.nowPlayingMoviesEndpoint}',
        queryParameters: {
          'api_key': AppConstants.apiKey,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = response.data['results'];
        return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      throw Exception('Error fetching now playing movies: $e');
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.movieDetailsEndpoint}/$movieId',
        queryParameters: {
          'api_key': AppConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        return MovieDetailsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error fetching movie details: $e');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.searchMoviesEndpoint}',
        queryParameters: {
          'api_key': AppConstants.apiKey,
          'query': query,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = response.data['results'];
        return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      throw Exception('Error searching movies: $e');
    }
  }

  @override
  Future<List<MovieModel>> searchTvShows(String query, {int page = 1}) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/search/tv',
        queryParameters: {
          'api_key': AppConstants.apiKey,
          'query': query,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> tvJson = response.data['results'];
        return tvJson.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search TV shows');
      }
    } catch (e) {
      throw Exception('Error searching TV shows: $e');
    }
  }

  @override
  Future<SeasonModel> getSeasonDetails(int tvId, int seasonNumber) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/tv/$tvId/season/$seasonNumber',
        queryParameters: {
          'api_key': AppConstants.apiKey,
        },
      );
      print('[DEBUG] Raw season response: ' + response.data.toString());
      if (response.statusCode == 200) {
        return SeasonModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load season details');
      }
    } catch (e) {
      throw Exception('Error fetching season details: $e');
    }
  }

  @override
  Future<TvDetailsModel> getTvDetails(int tvId) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}/tv/$tvId',
        queryParameters: {
          'api_key': AppConstants.apiKey,
        },
      );
      if (response.statusCode == 200) {
        return TvDetailsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load TV details');
      }
    } catch (e) {
      throw Exception('Error fetching TV details: $e');
    }
  }
}
