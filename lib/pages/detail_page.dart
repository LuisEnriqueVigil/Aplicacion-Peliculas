
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pelis_app/models/actores_model.dart';
import 'package:pelis_app/models/pelicula_model.dart';
import 'package:pelis_app/providers/actores_provider.dart';
import 'package:pelis_app/widgets/actores_pageView.dart';

class DetailPagePelicula extends StatelessWidget {
  
  final Pelicula pelicula; 
  DetailPagePelicula({this.pelicula});

  final actoresProvider = new ActoresProvider(); 

  @override
  Widget build(BuildContext context) {
    //si mando los argumentos usando pushNamed seria asi: 
    // final Pelicula pelicula = ModalRoute.of(context).settings.arguments; 

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(   //parecido al listView 
            delegate: SliverChildListDelegate(
              //recibe una lista de widgets
              [
                SizedBox(height: 10.0),
                _posterTitulo(pelicula),
                SizedBox(height: 20.0),
                _title('Resumen'),
                _descripcion(pelicula), 
                SizedBox(height: 5.0),
                _title('Reparto'),
                _traerActors(pelicula),  
              ]
            ), 
          )
        ],
      )
    );
  }

  Widget _title(String title) {
    return Row(
      children: <Widget>[
        SizedBox(width:20.0),
        Text(title,style: GoogleFonts.poppins(fontSize:18.0,fontWeight: FontWeight.w600),),
      ],
    );
  } 

 Widget _crearAppBar(Pelicula pelicula) {
   
   return SliverAppBar(
     elevation: 2.0,
     backgroundColor: Color(0xff032541),
     expandedHeight: 200.0, //que tan ancho sea expandido
     floating: false,
     pinned: true,

     flexibleSpace: FlexibleSpaceBar(
       centerTitle: true,

       title: Container(
         padding: EdgeInsets.all(8.0),
         height: 30.0, 
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey.withOpacity(0.40)
         ),
         child: Text(pelicula.title,
         style: TextStyle(color:Colors.white,fontSize: 12.0),),
       ),

       background: FadeInImage(
         placeholder: AssetImage('assets/loading.gif'), 
         image: NetworkImage( pelicula.getBackgroundPoster()),
         fit: BoxFit.cover,
         fadeInDuration: Duration(milliseconds: 200),
       ),
     ),
    //PARECIDO A LOS ACTIONS DEL APPBAR 
    //  actions: <Widget>[
    //    Container(
    //      height: 20.0,width: 20.0,
    //      decoration: BoxDecoration(shape: BoxShape.circle,color:Colors.white)
    //    )
    //  ],
   );
 }

  Widget _posterTitulo(Pelicula pelicula) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal:20.0),
      child:Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(0.5, 5),blurRadius:10)
              ]
            ),
            child: Hero(
              tag: pelicula.uniqueID,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  height: 150,
                  image: NetworkImage(pelicula.getImagen())),
              ),
            ),
          ),

          SizedBox(width: 20.0),
         
          Flexible( //es un widget que se adapta al espacio de un row con los widgets
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18.0, 
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.1
                  ),
                ), 

                Text(
                  pelicula.originalTitle,
                  style: TextStyle(
                    fontSize:15.0,
                    fontWeight: FontWeight.w300
                  ),
                ),
                
                SizedBox(height: 5.0),

                Container(
                  width: 115,
                  padding: EdgeInsets.symmetric(horizontal:5.0,vertical: 2.5),
                  decoration: BoxDecoration(
                    color:Color(0xff032541),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star, 
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 5.0),
                      Text(pelicula.popularity.toString(), 
                          style: GoogleFonts.poppins(fontSize:15,color: Color(0xff26D7AB),fontWeight: FontWeight.w400),    
                      )
                    ],
                  ),
                )

              ],
            )
          ), 

      ],)
    );

  }

  Widget _descripcion(Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: GoogleFonts.poppins(letterSpacing: 0.1),
      ),   
    );

  }

  Widget _traerActors(Pelicula pelicula) {

    return FutureBuilder(
      future: actoresProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if(snapshot.hasData){
           return ActoresPageView(
              actores:snapshot.data, 
          ); 
        }
        else{
          return Container(
            height: 150.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
          ); 
        } 
      }
    );

  }

  


}