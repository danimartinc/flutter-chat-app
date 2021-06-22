import 'package:flutter/material.dart';

//Preloading de la app, ya que mantiene toda la información en memoria, mantengo información persistente
class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading Page'),
     ),
   );
  }
}