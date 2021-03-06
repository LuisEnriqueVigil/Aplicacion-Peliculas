// Generated by https://quicktype.io

//recibe solo una info asi que se puede manejar sin list 
class ActorInfo {
  bool adult;
  List<String> alsoKnownAs;
  String biography;
  String birthday;
  dynamic deathday;
  int gender;
  String homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  ActorInfo({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment, 
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });
 
  ActorInfo.fromJsonMap (Map<String,dynamic> json){ 
    adult              = json['adult'];
    alsoKnownAs        = json['also_known_as'].cast<String>();
    biography          = json['biography'];
    birthday           = json['birthday'];
    deathday           = json['deathday'];
    gender             = json['gender'];
    homepage           = json['homepage'];
    id                 = json['id'];
    imdbId             = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name               = json['name'];
    placeOfBirth       = json['place_of_birth'];
    popularity         = json['popularity'];
    profilePath        = json['profile_path'];
  }

  getPhotoActor (){ 
    if(profilePath ==null){ 
      return 'https://img.icons8.com/officel/2x/circled-user-male-skin-type-6.png';
    }
    else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';}
  }
}
