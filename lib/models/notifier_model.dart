import 'package:flutter/material.dart';

class ModelNotifer extends ChangeNotifier { 

  int page = 0 ; 

  void unpdate (int valor){ 
    page= valor; 
    notifyListeners(); 

  }


}