import 'package:flutter/material.dart';

//Widget para establecer el formato de un botón de tipo ElevatedButton
class BlueButton extends StatelessWidget {

  final String text;
  //Función para disparar el action del botón
  final Function onPressed;

  //Constructor
  const BlueButton({
    Key? key, 
    required this.text, 
    required this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton (
      onPressed: () {
        this.onPressed;
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Center(
          child: Text( this.text, style: TextStyle( color: Colors.white, fontSize: 17 ) ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 2.0,
        primary: Colors.blue,
      ),
    );
  }
}