
import 'package:flutter/material.dart';

import 'package:pelis_app/pages/detail_page.dart';

//pages
import 'package:pelis_app/pages/home_page.dart';

 
 void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pelis App',
      initialRoute: 'home',
      routes: { 
        'home'  : (BuildContext context ) => HomePage(),
        'detail': (BuildContext context)  => DetailPagePelicula(),
      },
    );
  }
}