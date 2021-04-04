import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:pelis_app/models/pelicula_model.dart';
import 'package:pelis_app/providers/peliculas_provider.dart';
import 'package:pelis_app/search_delegate/search_delegate.dart';
import 'package:pelis_app/widgets/fondo_home.dart';


import 'package:pelis_app/widgets/horizontal_page.dart';

import 'package:pelis_app/widgets/swiper_tarjetas.dart';
import 'package:pelis_app/widgets/title_en_cines.dart';



class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final peliculasProvider = new PeliculasProvider(); 
  
  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopularMovie(); //carga las peliculas pero a su vez lanza el sink que esta contenido en su defincion
    peliculasProvider.getTopRated();
    peliculasProvider.getUpComming();

    final size = MediaQuery.of(context).size; 

    return Scaffold(
      body: SafeArea(
        child: Stack(//TODO: este stack lo puse para tratar de poner la sombra
          children: <Widget>[
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 7.0),
                  EnCinesWidget(),
                  _traerTarjetas(), 
                  SizedBox(height: size.height*0.0015),
                  _footerPeliculasPopulares(context), 
                  SizedBox(height: size.height*0.020),
                  _footerMovieTopRated(context),
                  SizedBox(height: size.height*0.030),
                  _footerMovieUpComming(context), 
                  SizedBox(height: size.height*0.035),
                ],
              ),
            ),
            buildBuscador(context),

          ],
        ),
      ),
    );
  }

  Widget buildBuscador(BuildContext context) {
   
    final size = MediaQuery.of(context).size; 
    return Positioned(
      left: size.width*0.69,
      top:  size.height*0.01,
      child: GestureDetector(
        onTap: (){
          showSearch(
            context: context, 
            delegate: BusquedaData(),
            // query: 'Busca tu pelicula fav' //este es un mensaje precargado
          );
        },
        child:Container(
            // padding: EdgeInsets.all(8.0),
            height: 40.0,
            width:110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color:Color(0xff26D7AB),
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  IconButton(
                    splashColor: Color(0xff032541),
                    color: Colors.indigo,
                    icon: Icon(Icons.search,size: 25.0), 
                    onPressed: (){
                      showSearch(
                        context: context, 
                        delegate: BusquedaData(),
                        // query: 'Busca tu pelicula fav' //este es un mensaje precargado
                      );
                    }
                  ),
                 Text('Buscar',style: GoogleFonts.poppins(fontSize:15.0),)
                ],
              ),
            ),
            ),
      ),
    );
  }

  Widget _traerTarjetas (){ 

    return FutureBuilder(
      future: peliculasProvider.getNowPlaying(), 
      builder: (BuildContext context,AsyncSnapshot <List<Pelicula>> snapshot ){
        
        //probamos ssi el snapshot trae info
        if(snapshot.hasData){
           return SwiperTarjetas(
              peliculas: snapshot.data, 
          );
        }
        else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
          ); 
        }
      },
    );
  }

  Widget _footerPeliculasPopulares(BuildContext context ){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[        //TODO: esto se puede modificar en el material app el texto
          Container(
            padding: EdgeInsets.only(left:20.0,bottom: 5.0),
            child: Text('Lo más popular',style: GoogleFonts.poppins(fontSize:18.0,fontWeight:FontWeight.w500)),
          ), 

          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
                if(snapshot.hasData){
                  return HorizontalPageView( 
                          //TODO: aqui le añadi la etiqueta de donde proviene
                          uniqueIDHero:'pop' ,
                          peliculas: snapshot.data,
                          siguientePagina: peliculasProvider.getPopularMovie); 
                }else{
                  return Container(
                    height: 150.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
            },
          ), 
        ],
      ),
    ); 
  }

  Widget _footerMovieTopRated ( BuildContext context){ 
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[  
          Container(
            padding: EdgeInsets.only(left:20.0,bottom: 5.0),
            child: Text('Mejores Calificadas',style:  GoogleFonts.poppins(fontSize:18.0,fontWeight:FontWeight.w500)
          )), 
          StreamBuilder(
            stream: peliculasProvider.topRatedStream,
            builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
                if(snapshot.hasData){
                  return HorizontalPageView(
                          //TODO: aqui le añadi la etiqueta de donde proviene
                          uniqueIDHero:'top',
                          peliculas: snapshot.data,
                          siguientePagina: peliculasProvider.getTopRated); 
                }else{
                  return Container(
                    height: 150.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
            },
          ), 
        ],
      ),
    );  
  }

  Widget _footerMovieUpComming(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[  
          Container(
            padding: EdgeInsets.only(left:20.0,bottom: 5.0),
            child: Text('Proximamente',style:  GoogleFonts.poppins(fontSize:18.0,fontWeight:FontWeight.w500))), 
         
          StreamBuilder(
            stream: peliculasProvider.upCommingStream,
            builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
                if(snapshot.hasData){
                  return HorizontalPageView(
                          //TODO: aqui le añadi la etiqueta de donde proviene
                          uniqueIDHero: 'up',
                          peliculas: snapshot.data,
                          siguientePagina: peliculasProvider.getUpComming); 
                }else{
                  return Container(
                    height: 150.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
            },
          ), 
        ],
      )
    ); 


  }

  Widget _traerFondo (){ 

    return FutureBuilder(
      future: peliculasProvider.getNowPlaying(), 
      builder: (BuildContext context,AsyncSnapshot <List<Pelicula>> snapshot ){
        
        //probamos ssi el snapshot trae info
        if(snapshot.hasData){
           return FondoHome(
              peliculas: snapshot.data, 
          );
        }
        else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
          ); 
        }
      },
    );
  }
  
}