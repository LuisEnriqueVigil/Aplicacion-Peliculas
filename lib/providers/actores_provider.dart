
import 'package:pelis_app/models/actores_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ActoresProvider { 
  String _apiKey='e41f9f4d119755b5a420013586695db2'; 
  String _url = 'api.themoviedb.org'; 
  String _lenguaje = 'es-ES'; 
 
  
  Future<List<Actor>> getCast (String movieID) async{ 

    final url = Uri.https(_url,'3/movie/$movieID/credits',{
      'api_key' : _apiKey,
      'language': _lenguaje,
    });

    final respuesta = await http.get(url); //toda la informacion traida cae en respuesta
    final decodeData = json.decode(respuesta.body); //decodeData recibe un mapa
  
    final cast = new Cast.fromJsonList(decodeData['cast']); 

    //aqui hacemos una impresion para ver si se creo la instacia de las peliculas.
    return cast.actores; 

  }

}