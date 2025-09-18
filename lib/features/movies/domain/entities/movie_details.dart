import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details.g.dart';

@JsonSerializable()
class MovieDetails extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final List<Genre>? genres;
  final int? runtime;
  final String? status;
  final String? tagline;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final double? budget;
  final double? revenue;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompany>? productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountry>? productionCountries;
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguage>? spokenLanguages;
  @JsonKey(name: 'popularity')
  final double? popularity;

  const MovieDetails({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.genres,
    this.runtime,
    this.status,
    this.tagline,
    this.originalLanguage,
    this.originalTitle,
    this.budget,
    this.revenue,
    this.productionCompanies,
    this.productionCountries,
    this.spokenLanguages,
  this.popularity,
  this.imdbId,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        releaseDate,
        genres,
        runtime,
        status,
        tagline,
        originalLanguage,
        originalTitle,
        budget,
        revenue,
        productionCompanies,
        productionCountries,
        spokenLanguages,
  popularity,
  imdbId,
      ];
}

@JsonSerializable()
class Genre extends Equatable {
  final int? id;
  final String? name;

  const Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);

  @override
  List<Object?> get props => [id, name];
}

@JsonSerializable()
class ProductionCompany extends Equatable {
  final int? id;
  final String? name;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  const ProductionCompany({
    this.id,
    this.name,
    this.logoPath,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);

  @override
  List<Object?> get props => [id, name, logoPath, originCountry];
}

@JsonSerializable()
class ProductionCountry extends Equatable {
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;
  final String? name;

  const ProductionCountry({
    this.iso31661,
    this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);

  @override
  List<Object?> get props => [iso31661, name];
}

@JsonSerializable()
class SpokenLanguage extends Equatable {
  final String? englishName;
  final String? iso6391;
  final String? name;

  const SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);

  @override
  List<Object?> get props => [englishName, iso6391, name];
}
