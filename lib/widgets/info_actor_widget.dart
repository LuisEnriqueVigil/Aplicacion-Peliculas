
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pelis_app/models/actor_info_model.dart';

class WidgetInfoActor extends StatelessWidget {
  final ActorInfo actorInfo; 
  const WidgetInfoActor({ this.actorInfo});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left:20.0,top:5.0,right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildLugarNacimiento(context),
          SizedBox(height: 10.0), 
          _fechaNacimientoPopularity(context), 
          SizedBox(height: 10.0),
          _buildBiografia()
        ],
      ),
    );
  }

  Widget _buildBiografia() {
    return Container(
          padding: EdgeInsets.symmetric(horizontal:20.0,vertical: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff032541),
            borderRadius: BorderRadius.circular(20.0)
          ),  
          child: _datosActor(
            'Un poco mas de ${actorInfo.name}', 
            (actorInfo.biography == '') ? 'no hay informacion':'${actorInfo.biography}'
          ),
        );
  }

  Widget _buildLugarNacimiento(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
            padding: EdgeInsets.only(left:16.0,top: 7.0,bottom: 7.0),
            height: size.height*0.13,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff032541),
              borderRadius: BorderRadius.circular(20.0)
            ),  
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _datosActor(
                  'Lugar de Nacimieto', 
                  (actorInfo.placeOfBirth==null )?'no hay informacion':'${actorInfo.placeOfBirth}'
                ),

                //icono de Nacimiento
                // Container(
                //   height: 40.0,width: 40.0,
                //   padding: EdgeInsets.all(9.0),
                //   decoration:BoxDecoration( 
                //     color: Colors.grey[400], 
                //     borderRadius: BorderRadius.circular(10.0), 
                //   ),
                //   child: Transform.rotate(
                //     angle: -pi/3.98,
                //     child: Image(image: AssetImage('assets/bebe.png'))
                //   ),
                // )

              ],
            ),
          ),
        );
  }

  Widget _fechaNacimientoPopularity(BuildContext context) {
    final size = MediaQuery.of(context).size; 
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //FECHA DE NACIMIENTO
            Container(
              padding: EdgeInsets.symmetric(vertical:8.0,horizontal: 15.0),
              height: size.height*0.12,
              width: size.width*0.43,
              decoration: BoxDecoration(
                color: Color(0xff032541),
                borderRadius: BorderRadius.circular(20.0)
              ),              
              child: Center(
                child: _datosActorRow(
                  'Nacimiento', 
                  (actorInfo.birthday == null)?'---':'${actorInfo.birthday}',
                  Icons.calendar_today, 
                ),
              ),
            ),
            //PUPULARIDAD
            Container(
               padding: EdgeInsets.symmetric(vertical:8.0,horizontal: 15.0),
              height:  size.height*0.12,
              width: size.width*0.43,
              decoration: BoxDecoration(
                color: Color(0xff032541),
                borderRadius: BorderRadius.circular(20.0)
              ),      
              child: Center(
                child:  _datosActorRow(
                  'Popularidad', actorInfo.popularity.toString(),
                  Icons.star,
                ) 
              ),
            )
          ],
        );
  }

  Widget _datosActor(String title, String info) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,style: GoogleFonts.poppins(fontSize:18.0,fontWeight: FontWeight.w500,color: Color(0xff26D7AB))),
                SizedBox(height: 5.0),
                Text(info,style: GoogleFonts.poppins(fontSize: 15.0,color: Colors.white),
                textAlign: TextAlign.justify,overflow: TextOverflow.clip),
              ],
            );
  }

  Widget _datosActorRow(String title, String info,IconData icon) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,style: GoogleFonts.poppins(fontSize:18.0,fontWeight: FontWeight.w500,color: Color(0xff26D7AB))),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(icon,color: Color(0xff26D7AB),),
                    SizedBox(width: 5.0),
                    Text(info,style: GoogleFonts.poppins(fontSize: 13.5,color: Colors.white),
                    textAlign: TextAlign.justify,),
                  ],
                ),
              ],
            );
  }
}