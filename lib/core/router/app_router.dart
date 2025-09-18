import 'package:go_router/go_router.dart';

import '../../features/movies/presentation/pages/home_page.dart';
import '../../features/movies/presentation/pages/movie_details_page.dart';
import '../../features/movies/presentation/pages/search_page.dart';
import '../../features/movies/presentation/pages/favorites_page.dart';
import '../../features/movies/presentation/pages/video_player_page.dart';

class AppRouter {
  static const String home = '/';
  static const String movieDetails = '/movie-details';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String videoPlayer = '/video-player';
  
  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '$movieDetails/:id',
        name: 'movie-details',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final type = state.uri.queryParameters['type'] ?? 'movie';
          return MovieDetailsPage(id: id, type: type);
        },
      ),
      GoRoute(
        path: search,
        name: 'search',
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: favorites,
        name: 'favorites',
        builder: (context, state) => const FavoritesPage(),
      ),
      GoRoute(
        path: videoPlayer,
        name: 'video-player',
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';
          final title = state.uri.queryParameters['title'] ?? 'Video Player';
          return VideoPlayerPage(url: url, title: title);
        },
      ),
    ],
  );
}
