import '../entities/movie_details.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetails {
  final MovieRepository repository;

  GetMovieDetails(this.repository);

  Future<MovieDetails> call(int movieId) async {
    return await repository.getMovieDetails(movieId);
  }
}
