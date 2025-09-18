class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '43d6f38a665b286acd81d1283a598199'; // Replace with your TMDB API key
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String imageBaseUrlOriginal = 'https://image.tmdb.org/t/p/original';
  
  // App Configuration
  static const String appName = 'Modern Movie App';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String favoritesBox = 'favorites';
  static const String watchlistBox = 'watchlist';
  
  // API Endpoints
  static const String popularMoviesEndpoint = '/movie/popular';
  static const String topRatedMoviesEndpoint = '/movie/top_rated';
  static const String nowPlayingMoviesEndpoint = '/movie/now_playing';
  static const String movieDetailsEndpoint = '/movie';
  static const String searchMoviesEndpoint = '/search/movie';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 1000;
}
