import 'package:flutter/material.dart';

class FondoCirculo extends StatelessWidget {
  const FondoCirculo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned (
      top: -220,right: -20.0,
      child: Container(
        height: 400.0,width: 400.0,
        decoration: BoxDecoration(
          color:Color( 0xff032541), 
          shape:BoxShape.circle,
        ),
      ),
    );
  }
}