import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  //Icono del Input
  final IconData icon;
  final String placeholder;
  //Controlador que permite obtener el valor actual del Input 
  final TextEditingController textController;
  //Tipo de formato de teclado
  final TextInputType keyboardType;
  //Flag para comprobar si el Input contiene un password
  final bool isPassword;

  const CustomInput({
    Key? key, 
    required this.icon, 
    required this.placeholder, 
    required this.textController, 
    this.keyboardType = TextInputType.text, 
    this.isPassword    = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( top: 5, left: 5, bottom:  5, right: 20 ),
      margin: EdgeInsets.only( bottom: 20 ),
      //Modifico el container mediante un BoxDecoration()
      decoration: BoxDecoration(
        color: Colors.white,
        //Borde redondeado 
        borderRadius: BorderRadius.circular( 30 ),
        //Implemetamos un sombreado bajo el Input
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black.withOpacity( 0.05 ),
            offset: Offset( 0, 5 ),
            blurRadius: 5
          )
        ]
      ),
      //TextField personalizado
      child: TextField(
        controller:  this.textController,
        //Evitamos el autocompletado de texto
        autocorrect: false,
        //Se establece el tipo de teclado dependiendo del tipo de Input seleccionado
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          //Icono en el interior del Input
          prefixIcon: Icon( this.icon ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder
        ),
      ),
    );
  }
}