import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnCinesWidget extends StatelessWidget {
  const EnCinesWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(8.0),
    height: 40.0,width: 90.0,
    decoration: BoxDecoration(
      color: Color(0xff032541),
      borderRadius: BorderRadius.circular(25.0)
    ),
    child: Center(
      child: Text('En cines',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:15.0,color: Color(0xff26D7AB)),
      )
    ),
   );
  }
}