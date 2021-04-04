import 'package:flutter/material.dart';
import 'package:pelis_app/models/pelicula_model.dart';
import 'package:pelis_app/pages/detail_page.dart';

class HorizontalPageView extends StatelessWidget {

  final List<Pelicula> peliculas;  
  final Function siguientePagina; 
  final String uniqueIDHero;
  HorizontalPageView({@required this.peliculas,@required this.siguientePagina, this.uniqueIDHero,});
  
  final _pageController = new PageController(
            initialPage: 1, 
            viewportFraction: 0.3
    );  
    
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    //se disparara cada vez que se mueva el scroll
    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
          siguientePagina(); 
      }
    });
    return Container(
       height: _screenSize.height*0.25,
       child: PageView.builder(     //nos permitira deslizar entre los widgets
          scrollDirection: Axis.horizontal, //con vertical tambien sale chevere
          pageSnapping: false,
          controller: _pageController,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index){ 
              return _tarjeta(context,peliculas[index]);
          },
          itemCount: peliculas.length,
       ),
    );
  }

  Widget _tarjeta (BuildContext context, Pelicula pelicula){ 

    pelicula.uniqueID = '${pelicula.id}-$uniqueIDHero';

    return GestureDetector(
      onTap: (){ 
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPagePelicula(pelicula: pelicula)));
        // Navigator.pushNamed(context, routeName, arguments: pelicula); //usando pushNamed para pasar datos
      },
      child: Container(
          padding: EdgeInsets.only(right: 10.0,top: 2.0),
          child: Column(
            children: <Widget>[
              Hero(
                tag: pelicula.uniqueID,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'), 
                    image: NetworkImage(pelicula.getImagen()),
                    fit: BoxFit.cover,
                    height: 150.0,
                  ),
                ),
              ),
              Text(pelicula.title,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
    );
  }

}