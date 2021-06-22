import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  //Ruta de navegación de la app
  final String route;
  //Textos de redirección de la parte inferior
  final String title;
  final String subTitle;

  //Constructor
  const Labels({
    Key? key, 
    required this.route,
    required this.title, 
    required this.subTitle
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text( this.title, style: TextStyle( color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300 ) ),
          SizedBox( height: 10, ),
          //Permite implementar cualquier gesto para realizar una acción
          GestureDetector(
            child: Text( this.subTitle, style: TextStyle( color: Colors.blue[600], fontSize: 15, fontWeight: FontWeight.bold  ) ),
            onTap: () {
              //pushReplacementNamed, nos permite navegar hacia la pantalla de register pero reemplazando por la ruta actual por lo que no puedo hacer el gesto
              Navigator.pushReplacementNamed(context, this.route );
            },
          ),
        ],
      ),
    );
  }
}