
//aqui se trabajara con los datos traido de la app// Generated by https://quicktype.io


class Peliculas { 

  List<Pelicula> itemsPeliculas = new List(); 
  Peliculas();

  //este constructor me va a permitir recibir el mapa de todas las peliculas del API ppara
  //luego pasarlo a un item 

  //vamos a recibir la info traida del API la Lista de peliculas 
  Peliculas.fromJsonList(List<dynamic> jsonList) { 

    if(jsonList == null) return; 

    //aqui vamos a barrer todo el listado, del mapa enviado de la Api
    for( var item in jsonList){ 

      final pelicula = new Pelicula.fromJsonMap(item); 
      itemsPeliculas.add(pelicula); 
    }
  }
}







//TODO: 
//se elimino el arreglo donde venian los idiomas y se cambio por un String de acuerdo a como trae la informacions
class Pelicula{
  String uniqueID;//creado para incorpordar el HERO

  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage; 
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  //aqui se trabaja la informacion no bien llegada de la API para un mejor uso 
  Pelicula.fromJsonMap (Map<String,dynamic> json) { 
    //TODO: se puede depurar la informacion poniendo puntito rojo en la linea 70
    adult           = json ['adult'];
    backdropPath    = json ['backdrop_path'];
    genreIds        = json ['genre_ids'].cast<int>(); 
    id              = json ['id'];
    originalLanguage= json ['original_language'];
    originalTitle   = json ['original_title'];
    overview        = json ['overview'];
    popularity      = json ['popularity'] / 1 ;
    posterPath      = json ['poster_path'];
    releaseDate     = json ['release_date'];
    title           = json ['title'];
    video           = json ['video'];
    voteAverage     = json ['vote_average'] / 1;
    voteCount       = json ['vote_count'];
  }
  //trear la imagen'

  getImagen (){ 
    if(posterPath ==null){ 
      return 'https://img.icons8.com/plasticine/2x/no-image.png';
    }
    else{
      return 'https://image.tmdb.org/t/p/w500/$posterPath';}
  }
  //trear poster imgaen grande 
  getBackgroundPoster(){ 
    if(backdropPath == null){
      return 'https://img.icons8.com/plasticine/2x/no-image.png'; 
    }else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}

