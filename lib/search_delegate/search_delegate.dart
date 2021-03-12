import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pelis_app/models/pelicula_model.dart';
import 'package:pelis_app/pages/detail_page.dart';
import 'package:pelis_app/providers/peliculas_provider.dart';

class BusquedaData extends SearchDelegate{

  final peliculasProvider = new PeliculasProvider(); 
  String seleccion = ''; 

  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones de nuestro app bar, por ejemplo un icono para limpiar o cancelar la busqueda
      return [
        IconButton( 
          icon: Icon(Icons.clear), 
          onPressed: (){
            //almacenara la informacion escrita NO HACE FALTA SET STATE
            query = '';
          }
        )
      ];     
  }
  
    @override
    Widget buildLeading(BuildContext context) {
      // lo que aparece al inicio en nuestro caso el icono de la lupa a la izquierda de nuestro appbar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow , 
          progress: transitionAnimation,
        ), 
        onPressed: (){
          close(context, null);
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // crea los resultados que vamos a mostrar 
      return Center(
        child: Container(
           height: 100.0,
           width: 100.0,
           color: Colors.blueAccent,
           child: Text(seleccion),
        )); 
    }
  
    @override
    Widget buildSuggestions (BuildContext context) {
    if (query.isEmpty){ 
      return Center(
        child: Container(
          // margin: EdgeInsets.symmetric(),
          child: Text(
            'Tenemos cualquier película\nsolo escribe',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 15.0),
          ),
        ),
      ); 
    }
    return FutureBuilder(
      future: peliculasProvider.peliculaBusqueda(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){ 
        
        if( snapshot.hasData){
          final peliculas =  snapshot.data; 
          return ListView(
            //convertir las peliculas en un arreglo de widget
            children: peliculas.map(
              (pelicula) { 
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'), 
                    image: NetworkImage(pelicula.getImagen()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ), 
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    close(context, null); //cerramos la busqueda, 
                    pelicula.uniqueID = ''; 
                    Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DetailPagePelicula(pelicula: pelicula)
                    )
                  ); 
                  },
                ); 
              }
            ).toList(),  
          ); 
        }else{ 
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      }, 
    );
  }




}