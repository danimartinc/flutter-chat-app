import 'package:flutter/material.dart';

//Método para definir el Widget del Logo de la App
class Logo extends StatelessWidget {

  final String title;

  //Constructor
  const Logo({
    Key? key, 
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only( top: 50 ),
        child: Column(
          children: [
            Image( image: AssetImage('assets/tag-logo.png') ),
            SizedBox( height: 20 ),
            Text( this.title, style: TextStyle( fontSize: 30 ) )
          ],
        ),    
      ),
    );
  }
}