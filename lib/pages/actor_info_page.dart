import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pelis_app/models/actor_info_model.dart';
import 'package:pelis_app/models/actores_model.dart';
import 'package:pelis_app/providers/actor_info_provider.dart';
import 'package:pelis_app/widgets/fondo_circulo.dart';
import 'package:pelis_app/widgets/info_actor_widget.dart';


class ActorPageInfo extends StatelessWidget {

  final Actor actor; 
 
  ActorPageInfo({this.actor});

  final actorinfoProvider =  new InfoActorProvider();
  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size; 
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FondoCirculo(),
          SafeArea( 
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: _screenSize.height*0.025),
                    _photoActor(_screenSize),
                    Text('${actor.originalName}',
                        style: GoogleFonts.poppins(fontSize:20.0,fontWeight: FontWeight.bold,color: Color(0xff26D7AB))
                    ),
                    Text('${actor.knownForDepartment}',
                        style: GoogleFonts.poppins(fontSize: 20.0,fontWeight: FontWeight.w600,color: Color(0xff26D7AB).withOpacity(0.5)),
                    ),
                    _traerInfo(), 
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoActor(Size _screenSize) {
    return Container(
      // color: Colors.red,
      height: _screenSize.height*0.28,
      child: Center(
        child: 
            Container(
              child:Hero(
                tag: actor.id,
                child: CircleAvatar( 
                  backgroundImage: NetworkImage(actor.getPhotoActor()), 
                  radius: _screenSize.height*0.15,               
                ),
              )
        ),
      ),
    );
  }

  Widget _traerInfo() {
    return FutureBuilder(
      future: actorinfoProvider.getInfoActor(actor.id.toString()),
      builder: (BuildContext context , AsyncSnapshot<ActorInfo> snapshot) {
        
        if(snapshot.hasData){ 
          return WidgetInfoActor( 
            actorInfo: snapshot.data,
          );
        }else{ 
          return  Container(
            height: 150.0,
            child: Center(
              child: CircularProgressIndicator()
            )
        );
      }}
    );
  }
}