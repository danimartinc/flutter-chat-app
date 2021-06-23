import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String uid;
  final String text;
  //Controller para manejar la animación cuando se envia un mensaje en el chat
  final AnimationController animationController;

  const ChatMessage({
    Key? key, 
    required this.uid, 
    required this.text,
    required this.animationController
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    //FadeTransition(), nos permite controlar la transicción del cambio de la opacidad
    return FadeTransition(
      opacity: animationController,
      //SizeTransition, permite transformar el tamaño del Widget
      child: SizeTransition(
        sizeFactor: CurvedAnimation( 
          parent: animationController, 
          curve: Curves.easeOut 
        ),
        child: Container(
          //Mediante el UID asociado al mensaje, diferenciamos entre los mensajes que envia el propio usuario, y los que vienen de otro emisor
          //Si el UID del usuario autenticado coincide con el mensaje mostramos myMessage()
          child: this.uid == '123'
                    ? _myMessage()
                    //En caso contrario, mensaje enviado por otro usuario
                    : _notMyMessage(),
        ),
      ),
    );
  }

  //Widget para msotrar el mensaje del usuario autenticado actualmente
  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          left: 50,
          right: 7
        ),
        //Texto del mensaje
        child: Text( this.text, style: TextStyle( color: Colors.white ), ),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular( 20 )
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 5,
          right: 50,
          left: 7
        ),
        //Texto del mensaje
        child: Text( this.text, style: TextStyle( color: Colors.black87 ), ),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular( 20 )
        ),
      ),
    );
  }
}