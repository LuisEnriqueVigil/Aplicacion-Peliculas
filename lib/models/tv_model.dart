// Generated by https://quicktype.io



class TvPrograms {
  String backdropPath;
  String firstAirDate;
  List<int> genreIds;
  int id;
  String name;
  List<OriginCountry> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  double voteAverage;
  int voteCount;

  TvPrograms({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });
}
//TODO: FALTA DARLE LA CARPINTERIA DE PASAR A JSON
enum OriginCountry { US, DE, JP }