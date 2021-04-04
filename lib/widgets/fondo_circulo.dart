import 'package:flutter/material.dart';

class FondoCirculo extends StatelessWidget {
  const FondoCirculo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned (
      top: -size.height*0.30,right: -2.5,
      child: Container(
        height: size.height*0.62,
        width: size.height*0.61,
        decoration: BoxDecoration(
          color:Color( 0xff032541), 
          shape:BoxShape.circle,
        ),
      ),
    );
  }
}