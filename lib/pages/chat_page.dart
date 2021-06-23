import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
//Widgets
import 'package:chat_app/widgets/chat_,message.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

//TickerProviderStateMixin, nos permite realizar la sincronización con el vertical sync para implementar varias animaciones
class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  //Controller para el TextField() de la caja de texto
  final _textController = new TextEditingController();
  //Permite controlar el focus en los Widgets
  final _focusNode      = new FocusNode();

  //Lista de Mensajes
  List<ChatMessage> _messages = [];

  //Flag para controlar si el usuario está o no escribiendo, y saber si deshabilitamos/habilitamos el botón
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              //Iniciales del usuario
              child: Text( 'Te', style: TextStyle( fontSize: 12 ) ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox( height: 3 ),
            Text('Jaycee Carroll', style: TextStyle( color: Colors.black87, fontSize: 12 ), )
          ],
        ),
        //Nos permite centrar el título en el AppBar()
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            //Widget que permite expandir el Widget para que ocupe todo el espacio disponible
            Flexible(
              child: ListView.builder(
                //Animación
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                //Recorro el listado de mensajes del chat
                itemBuilder: ( BuildContext context, int index ) => _messages[index],
                //Ordenamos el ListView de manera que se muestre el primero en el Chat
                reverse: true,
              ),
            ),
            Divider( height: 1 ),
            //TODO: Caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {

    //SafeArea()
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8.0 ),
        child: Row(
          children: [
            //Flexible(), nos permite expandir el Textfield() por todo el espacio disponible
            Flexible(
              //TextField(), widget para la caja de texto
              child: TextField(
                controller: _textController,
                //Dispara la acción del _handleSubmit
                onSubmitted: _handleSubmit,
                //Dispara el 
                onChanged: ( text ){
                  //Conocer cuando hay un valor en el TextField() para poder realizar el POST del submit
                   setState(() {
                    //Compruebo que si el TextField tiene un texto que contiene al menos un caracter, el usuario está escribiendo
                    if ( text.trim().length > 0 ) {
                      _isTyping = true;
                    } else {
                      _isTyping = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  //Texto que aparece en el interior del TextField()
                  hintText: 'Enviar mensaje'
                ),
                //Para mantener el focus en el TextField() tras pulsar el botón Enviar
                focusNode: _focusNode,
              )
            ),

            //Botón de enviar
            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0 ),
              //Mostramos el contenido dependiendo de la plataforma en la que nos encontremos
              //Validamos la plataforma en la que nos encontramos mediante un operador ternario
              child: Platform.isIOS
              ? CupertinoButton(
                //Botón para IOs
                child: Text('Enviar'), 
                //Cuando el TextField() no contiene un valor, deshabilitamos el botón de Enviar
                onPressed: _isTyping
                  //Si el usuario está escribiendo, habilito el botón
                  ? () => _handleSubmit( _textController.text.trim() )
                  : null,  
              )

              : Container(
                //Botón para Android
                margin: EdgeInsets.symmetric( horizontal: 4.0 ),
                //IconTheme(), nos permite controlar el color del botón Enviar
                child: IconTheme(
                  data: IconThemeData( color: Colors.blue[400] ),
                  child: IconButton(
                    //Elimina el efecto del botón
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon( Icons.send ),
                    //Cuando el TextField() no contiene un valor, deshabilitamos el botón de Enviar
                    onPressed: _isTyping
                      //Si el usuario está escribiendo, habilito el botón
                      ? () => _handleSubmit( _textController.text.trim() )
                      : null,         
                  ),
                ),
              ),
            )

          ],
        ),
      )
    );

  }

  //Función que permite el valor del Input
  _handleSubmit( String text ) {

    //Validamos que para pulsar el botón Enviar, debe tener contenido el cuadro de texto
    if ( text.length == 0 ) return;

    //Limpiamos el input de la caja de texto
    _textController.clear();
    //Solicitamos el focus, para perder el focus hacía el Widget
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123', 
      text: text,
      animationController: AnimationController( vsync: this, duration: Duration( milliseconds: 200 ) ),
    );

    //Realizamos la isnercción en la lista de mensajes
    _messages.insert( 0,  newMessage );

    //Indicamos que empiece la animación tras realizar la insercción
    newMessage.animationController.forward();

    setState(() { _isTyping = false; });
  }

  //Nos permite destruir el Widget tras implementarlo
  @override
  void dispose() {

    //Limpiamos cada una de las instancias del array de mensajes y animationControllers
    for( ChatMessage message in _messages ) {
      message.animationController.dispose();
    }

    //this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }

  

}