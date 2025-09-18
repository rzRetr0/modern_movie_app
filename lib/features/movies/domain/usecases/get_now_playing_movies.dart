import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<List<Movie>> call({int page = 1}) async {
    return await repository.getNowPlayingMovies(page: page);
  }
}
