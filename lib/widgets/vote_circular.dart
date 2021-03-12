import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:pelis_app/models/actores_model.dart';
import 'package:pelis_app/models/pelicula_model.dart';
class VoteCircular extends StatefulWidget {

  final Pelicula pelicula;
  final Actor actor;  
  final bool esPelicula;
  final double alturaCirculo; 
  final double anchoCirculo; 
  final double top; 
  final double right; 
  const VoteCircular({this.pelicula, this.top, this.right, this.esPelicula, this.actor, this.alturaCirculo, this.anchoCirculo});

  @override
  _VoteCircularState createState() => _VoteCircularState();
}

class _VoteCircularState extends State<VoteCircular> {
  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: widget.top,
      right:widget.right,
      child: Container(
      height: widget.alturaCirculo,
      width: widget.anchoCirculo,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(0.8, -5),blurRadius:10)
        ],
        color:Color(0xff0089B3),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
        child: (widget.esPelicula)?
                Text('${(widget.pelicula.voteAverage*10).toInt().toString()}%',
                style: GoogleFonts.poppins(fontSize: 15.0,color: Color(0xff26D7AB),fontWeight: FontWeight.bold),) 
                : 
                Text('${(widget.actor.popularity.toString())}',
                style: GoogleFonts.poppins(fontSize: 15.0,color: Color(0xff26D7AB),fontWeight: FontWeight.bold),)
      ),
    )
  );
  }
}