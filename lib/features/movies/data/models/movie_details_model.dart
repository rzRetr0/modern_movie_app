import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_details.dart';

part 'movie_details_model.g.dart';

@JsonSerializable()
class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.id,
    required super.title,
    super.overview,
    super.posterPath,
    super.backdropPath,
    super.voteAverage,
    super.voteCount,
    super.releaseDate,
    super.genres,
    super.runtime,
    super.status,
    super.tagline,
    super.originalLanguage,
    super.originalTitle,
    super.budget,
    super.revenue,
    super.productionCompanies,
    super.productionCountries,
    super.spokenLanguages,
    super.popularity,
    super.imdbId,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => 
      _$MovieDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsModelToJson(this);
}

@JsonSerializable()
class GenreModel extends Genre {
  const GenreModel({
    int? id,
    String? name,
  }) : super(
    id: id,
    name: name,
  );

  factory GenreModel.fromJson(Map<String, dynamic> json) => 
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}

@JsonSerializable()
class ProductionCompanyModel extends ProductionCompany {
  const ProductionCompanyModel({
    int? id,
    String? name,
    String? logoPath,
    String? originCountry,
  }) : super(
    id: id,
    name: name,
    logoPath: logoPath,
    originCountry: originCountry,
  );

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) => 
      _$ProductionCompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyModelToJson(this);
}

@JsonSerializable()
class ProductionCountryModel extends ProductionCountry {
  const ProductionCountryModel({
    String? iso31661,
    String? name,
  }) : super(
    iso31661: iso31661,
    name: name,
  );

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) => 
      _$ProductionCountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryModelToJson(this);
}

@JsonSerializable()
class SpokenLanguageModel extends SpokenLanguage {
  const SpokenLanguageModel({
    String? englishName,
    String? iso6391,
    String? name,
  }) : super(
    englishName: englishName,
    iso6391: iso6391,
    name: name,
  );

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) => 
      _$SpokenLanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageModelToJson(this);
}
