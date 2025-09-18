import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/movies/presentation/bloc/movie_bloc.dart';
import 'features/movies/data/datasources/movie_remote_datasource.dart';
import 'features/movies/data/repositories/movie_repository_impl.dart';
import 'features/movies/domain/repositories/movie_repository.dart';
import 'features/movies/domain/usecases/get_popular_movies.dart';
import 'features/movies/domain/usecases/get_top_rated_movies.dart';
import 'features/movies/domain/usecases/get_now_playing_movies.dart';
import 'features/movies/domain/usecases/get_movie_details.dart';
import 'features/movies/domain/usecases/search_movies.dart';
import 'features/movies/domain/usecases/search_tv_shows.dart';
import 'features/movies/domain/usecases/get_tv_details.dart';
import 'features/movies/domain/usecases/get_season_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Initialize Hive for local storage
  await Hive.initFlutter();

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(
            getPopularMovies: GetPopularMovies(_getMovieRepository()),
            getTopRatedMovies: GetTopRatedMovies(_getMovieRepository()),
            getNowPlayingMovies: GetNowPlayingMovies(_getMovieRepository()),
            getMovieDetails: GetMovieDetails(_getMovieRepository()),
            getTvDetails: GetTvDetails(_getMovieRepository()),
            searchMovies: SearchMovies(_getMovieRepository()),
            searchTvShows: SearchTvShows(_getMovieRepository()),
            getSeasonDetails: GetSeasonDetails(_getMovieRepository()),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Merl Cinema',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  MovieRepository _getMovieRepository() {
    return MovieRepositoryImpl(
      remoteDataSource: MovieRemoteDataSourceImpl(dio: Dio()),
    );
  }
}
