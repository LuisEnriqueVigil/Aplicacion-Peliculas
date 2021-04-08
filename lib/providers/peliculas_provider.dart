


import 'package:pelis_app/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


 
 //TODO: aqui hay informacion fundamental para entender como traer informacion de una API 

class PeliculasProvider{ 

  //DATOS DE LA API SEGUN LOS DATOS QUE SE REQUIEREN 
  String _apiKey='e41f9f4d119755b5a420013586695db2'; 
  String _url = 'api.themoviedb.org'; 
  String _lenguaje = 'es-ES'; 

  int _popularesPage = 0 ; 
  int _topRatedPage = 0 ; 
  int _upCommingPage = 0 ; 

  bool _cargando = false; //optimiazacion 
  bool _cargandoTop = false; 
  bool _cargandoComming = false; 

  //TODO: uso del stream 

  List<Pelicula> _peliculasPopulares = []; 

                          //se especifica que tipo de informacion se transmitira
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast(); 

//introducir estas peliculas
  Function (List<Pelicula>) get popularesSink =>_popularesStreamController.sink.add; 

//escuchar lo sacado del stream
  Stream <List<Pelicula>> get popularesStream => _popularesStreamController.stream; 

  //---------------------------------------------------
  //STREAM PARA TRAER LAS PELICULAS MEJOR RANKEADAS 
  List<Pelicula> _peliculasTopRated = []; 
  
  final _topRatedStreamController = StreamController<List<Pelicula>>.broadcast(); 

  Function (List<Pelicula>) get topRatedSink => _topRatedStreamController.sink.add; 

  Stream <List<Pelicula>> get topRatedStream => _topRatedStreamController.stream; 
  
  //----------------------------------------------------
  //STREAM PARA TRAER PELICULAS EN ESTRENO 
  List<Pelicula> _peliculasProximas = []; 

  final _proxMovieStreamController = StreamController<List<Pelicula>>.broadcast(); 
  
  Function (List<Pelicula>) get upCommingSink => _proxMovieStreamController.sink.add;

  Stream <List<Pelicula>> get upCommingStream => _proxMovieStreamController.stream; 

  
  //cerrar los streams cuando salgamos de la paginas
  void disposeStream (){ 
    _popularesStreamController?.close(); 
  }
  void disposeStreamTop(){ 
    _topRatedStreamController?.close();
  }

  void disposeUpComming(){
    _proxMovieStreamController?.close(); 
  }

  //TODO: aqui puedo agregar otros futures que consuman diferentes datos de la API 
  Future<List<Pelicula>> getNowPlaying () async{ 

    final url = Uri.https(_url,'3/movie/now_playing',{
      'api_key' : _apiKey,
      'language': _lenguaje,
    });

    final respuesta = await http.get(url); //retorna toda la respuesta http 
    final decodeData = json.decode(respuesta.body); //en el body viene toda la respuesta y VIENE EN UN MAPA
    
    //decodeData['results] esto trae el listado completo de las peliculas de la API 

    //barrera toda la lista traida de la API y creara una instacia de cada pelicula 
    final peliculas = new Peliculas.fromJsonList(decodeData['results']); //convertimos esto en una pelicula

    //aqui hacemos una impresion para ver si se creo la instacia de las peliculas.
    //print (peliculas.itemsPeliculas[0].title);

    return peliculas.itemsPeliculas; //retorna las peliculas listas para ser usadas

  }

  Future <List<Pelicula>> getPopularMovie () async{ 
    if(_cargando) return []; //optimiazacion 

    _cargando = true; //optimiazacion 
    _popularesPage ++; 

      final url = Uri.https(_url,'3/movie/popular',{
      'api_key' : _apiKey,
      'language': _lenguaje, 
      'page'    : _popularesPage.toString(),
      });
      final resp = await http.get(url);
      final decodeData = json.decode(resp.body); 
      final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    final respuesta =  peliculas.itemsPeliculas; 
    _peliculasPopulares.addAll(respuesta); 
    popularesSink(_peliculasPopulares); 
    _cargando =false; //optimiazacion 
    return respuesta; 
  }

  Future <List<Pelicula>> getTopRated() async{ 
    if(_cargandoTop) return []; 
    _cargandoTop = true; 
    _topRatedPage ++ ; 
    final url = Uri.https(_url,'3/movie/top_rated',{
      'api_key' : _apiKey,
      'language': _lenguaje, 
      'page'    : _topRatedPage.toString(),
      });
      final resp = await http.get(url);
      final decodeData = json.decode(resp.body); 
      final peliculas = new Peliculas.fromJsonList(decodeData['results']);

      final respuesta = peliculas.itemsPeliculas; 
      _peliculasTopRated.addAll(respuesta); 
      topRatedSink(_peliculasTopRated);
      _cargandoTop = false; 
      // print(_topRatedPage.toString());
      return respuesta; 

  }
  
  Future <List<Pelicula>> getUpComming () async { 

    if(_cargandoComming) return []; 

    _cargandoComming = true; 
    _upCommingPage ++; 

    final url = Uri.https(_url,'3/movie/upcoming',{
      'api_key' : _apiKey,
      'language': _lenguaje, 
      'page'    : _topRatedPage.toString(),
    });
    final resp =  await http.get(url); 
    final decodeData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']); 
    
    final respuesta = peliculas.itemsPeliculas;
    _peliculasProximas.addAll(respuesta); 
    upCommingSink (_peliculasProximas);
    _cargandoComming =  false; 
    return respuesta; 
  }



///IMPLEMENTACION DEL PROVIDER PARA BUSQUEDA DE PELICULA
  Future<List<Pelicula>> peliculaBusqueda(String query)async{ 

    final url = Uri.https(_url,'3/search/movie',{
      'api_key' : _apiKey,
      'language': _lenguaje,
      'query'   : query
    });

    final respuesta = await http.get(url); 
    final decodeData = json.decode(respuesta.body); 
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.itemsPeliculas; 

  }


}