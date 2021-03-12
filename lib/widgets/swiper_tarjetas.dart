import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pelis_app/models/pelicula_model.dart';
import 'package:pelis_app/pages/detail_page.dart';
// import 'package:pelis_app/widgets/title_en_cines.dart';
import 'package:pelis_app/widgets/vote_circular.dart';

class SwiperTarjetas extends StatefulWidget {
 
  final List<Pelicula> peliculas;

  const SwiperTarjetas({ @required this.peliculas}); 

  @override
  _SwiperTarjetasState createState() => _SwiperTarjetasState();
}

class _SwiperTarjetasState extends State<SwiperTarjetas> {
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size; 
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top:10.0),
          height: _screenSize.height*0.52,
          width: double.infinity,

          child: Swiper(
            itemBuilder: (BuildContext context,int index){
              //TODO: aqui se puede incorporar algunas funciones
              widget.peliculas[index].uniqueID = '${widget.peliculas[index].id}-tarjetas'; 

              return GestureDetector(
                onTap: (){ 
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              DetailPagePelicula(pelicula: widget.peliculas[index],)));  
                },
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: widget.peliculas[index].uniqueID,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: FadeInImage (
                        image: NetworkImage(widget.peliculas[index].getImagen()),
                          placeholder: AssetImage('assets/no-image.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    VoteCircular(
                      alturaCirculo: 50.0,
                      anchoCirculo: 50.0,
                      esPelicula: true,
                      right: _screenSize.width*0.020,
                      top: _screenSize.height*0.425,
                      pelicula: widget.peliculas[index]
                    ),
                  ],
                ),
              );
            },
            itemCount: widget.peliculas.length,
            viewportFraction: 0.6,
          //el swiper necesita dimentsiones
            // itemHeight: _screenSize.height*0.20,
            // itemWidth: _screenSize.width*0.20,
            scale: 0.5,
            // layout: SwiperLayout.STACK,
            // pagination: SwiperPagination(), // los puntitos en la parte de abjo que muestra la paginacion
            // control: SwiperControl(), //las barras laterales que indican que se puede cambiar  <   >
          ),
        ),
      ],
    );
  }
}