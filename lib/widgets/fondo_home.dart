
import 'package:flutter/material.dart';
import 'package:pelis_app/models/pelicula_model.dart';

class FondoHome extends StatelessWidget {
  final List<Pelicula> peliculas ; 
   FondoHome({ this.peliculas});

  final pageController = new PageController(
    viewportFraction: 1.05
  ); 

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size; 
    return Container(
       height: _screenSize.height*0.70,
       child: PageView.builder(     //nos permitira deslizar entre los widgets
          scrollDirection: Axis.horizontal, //con vertical tambien sale chevere
          pageSnapping: true,
          controller: pageController,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index){ 
              return FadeInImage (
               image: NetworkImage(peliculas[index].getImagen()),
               placeholder: AssetImage('assets/no-image.jpg'),
               fit: BoxFit.fill,
            );
          },
          itemCount: peliculas.length,
       ),
    );
  }
}