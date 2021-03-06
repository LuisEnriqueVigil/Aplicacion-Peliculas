// Generated by https://quicktype.io


//esta instancia recibira toda la lista de actores

class Cast {
  
  List<Actor> actores = []; 

  //instacia de esta clase
  Cast.fromJsonList(List<dynamic> jsonList){ 
    if(jsonList == null) return; 

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item); 
      actores.add(actor); 
    });
  }

}





class Actor{
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;


  Actor ({
    this.adult, 
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  Actor.fromJsonMap(Map<String,dynamic> json){ 

    adult               = json ['adult'];
    gender              = json ['gender'];
    id                  = json ['id'];
    knownForDepartment  = json ['known_for_department'];
    name                = json ['name'];
    originalName        = json ['original_name'];
    popularity          = json ['popularity'];
    profilePath         = json ['profile_path'];
    castId              = json ['cast_id'];
    character           = json ['character'];
    creditId            = json ['credit_id'];
    order               = json ['order'];
  }

  getPhotoActor (){ 
    if(profilePath ==null){ 
      return 'https://img.icons8.com/officel/2x/circled-user-male-skin-type-6.png';
    }
    else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';}
  }



}

