import '../repositories/movie_repository.dart';
import '../entities/season.dart';

class GetSeasonDetails {
  final MovieRepository repository;
  GetSeasonDetails(this.repository);

  Future<Season> call(int tvId, int seasonNumber) async {
    return await repository.getSeasonDetails(tvId, seasonNumber);
  }
}
