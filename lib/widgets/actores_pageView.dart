import 'package:flutter/material.dart';
import 'package:pelis_app/models/actores_model.dart';
import 'package:pelis_app/pages/actor_info_page.dart';

class ActoresPageView extends StatelessWidget {

  final List<Actor> actores; 
   ActoresPageView({ this.actores});

  final _pageController = new PageController(
            initialPage: 1, 
            viewportFraction: 0.3
    ); 
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size; 
    return Container(
       height: _screenSize.height*0.25,
       child: PageView.builder(     //nos permitira deslizar entre los widgets
          scrollDirection: Axis.horizontal, //con vertical tambien sale chevere
          controller: _pageController,
          pageSnapping: false,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index){ 
              return _tarjeta(context,actores[index]);
          },
          itemCount: actores.length,
       ),
    );
  }

  Widget _tarjeta(BuildContext context, Actor actor) {

    return Container(
          padding: EdgeInsets.only(right: 10.0,top: 2.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (contex)=> ActorPageInfo(actor: actor)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), 
                  ),
                  child: Hero(
                    tag: actor.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/no-image.jpg'), 
                        image: NetworkImage(actor.getPhotoActor()),
                        fit: BoxFit.contain,
                        height: 150.0,
                      ),
                    ),
                  ),
                ),
              ),
              Text(actor.originalName,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        );
  }
}