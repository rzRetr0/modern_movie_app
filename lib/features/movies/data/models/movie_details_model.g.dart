// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsModel _$MovieDetailsModelFromJson(Map<String, dynamic> json) =>
    MovieDetailsModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      releaseDate: json['release_date'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      runtime: (json['runtime'] as num?)?.toInt(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      budget: (json['budget'] as num?)?.toDouble(),
      revenue: (json['revenue'] as num?)?.toDouble(),
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      imdbId: json['imdb_id'] as String?,
    );

Map<String, dynamic> _$MovieDetailsModelToJson(MovieDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'release_date': instance.releaseDate,
      'genres': instance.genres,
      'runtime': instance.runtime,
      'status': instance.status,
      'tagline': instance.tagline,
      'imdb_id': instance.imdbId,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'budget': instance.budget,
      'revenue': instance.revenue,
      'production_companies': instance.productionCompanies,
      'production_countries': instance.productionCountries,
      'spoken_languages': instance.spokenLanguages,
      'popularity': instance.popularity,
    };

GenreModel _$GenreModelFromJson(Map<String, dynamic> json) => GenreModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenreModelToJson(GenreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProductionCompanyModel _$ProductionCompanyModelFromJson(
        Map<String, dynamic> json) =>
    ProductionCompanyModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      logoPath: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String?,
    );

Map<String, dynamic> _$ProductionCompanyModelToJson(
        ProductionCompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_path': instance.logoPath,
      'origin_country': instance.originCountry,
    };

ProductionCountryModel _$ProductionCountryModelFromJson(
        Map<String, dynamic> json) =>
    ProductionCountryModel(
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductionCountryModelToJson(
        ProductionCountryModel instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso31661,
      'name': instance.name,
    };

SpokenLanguageModel _$SpokenLanguageModelFromJson(Map<String, dynamic> json) =>
    SpokenLanguageModel(
      englishName: json['englishName'] as String?,
      iso6391: json['iso6391'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SpokenLanguageModelToJson(
        SpokenLanguageModel instance) =>
    <String, dynamic>{
      'englishName': instance.englishName,
      'iso6391': instance.iso6391,
      'name': instance.name,
    };
