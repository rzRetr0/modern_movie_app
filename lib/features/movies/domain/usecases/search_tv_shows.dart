import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchTvShows {
  final MovieRepository repository;

  SearchTvShows(this.repository);

  Future<List<Movie>> call(String query, {int page = 1}) async {
    return await repository.searchTvShows(query, page: page);
  }
}
