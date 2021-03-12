import 'package:pelis_app/models/actor_info_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class InfoActorProvider {  
  String _apiKey='e41f9f4d119755b5a420013586695db2'; 
  String _url = 'api.themoviedb.org'; 
  String _lenguaje = 'es-ES'; 
 
  
  Future <ActorInfo> getInfoActor (String actorID) async{ 

    final url = Uri.https(_url,'3/person/$actorID',{
      'api_key' : _apiKey,
      'language': _lenguaje,
    });

    final respuesta = await http.get(url); //toda la informacion traida cae en respuesta
    final decodeData = json.decode(respuesta.body); //decodeData recibe un mapa
  
    final infoactor = new ActorInfo.fromJsonMap(decodeData); 

    //aqui hacemos una impresion para ver si se creo la instacia de las peliculas.
    return infoactor; 
 
  }

}