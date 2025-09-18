import '../entities/tv_details.dart';
import '../repositories/movie_repository.dart';

class GetTvDetails {
  final MovieRepository repository;
  GetTvDetails(this.repository);

  Future<TvDetails> call(int tvId) async {
    return await repository.getTvDetails(tvId);
  }
}
