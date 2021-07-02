import 'package:chat_app/models/messages_response.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/global/environment.dart';
import 'package:http/http.dart' as http;
//Models
import 'package:chat_app/models/user.dart';
//Providers
import 'auth_service.dart';

//Nos permite expandir la comunicación con el Servidor en cualquier punto de la app, se puede utilziar de forma global
//ChangeNotifier, permite indicar al Provider cuando tiene que refrescar la interfaz o volver a renderizar un componente, si se produce algún cambio o se quiere notificar a los clientes
class ChatService with ChangeNotifier {

  //Instancia de User, para el usuario que recibe los mensajes del chat
  User? receivingUser;
  
  //Petición asíncrona para obtener el listado mensajes de un Chat
  Future<List<Message>> getChat( String userID ) async {

    //Obtenemos el JWT desde el authService
    String? token = await AuthService.getToken();

    if( token == null ){
      token = '';
    }

    //Endpoint para obtener el listado de mensajes del chat para cada UID
    final uri = Uri.parse('${ Environment.apiURL }/messages/$userID');

    //Petición GET, en la cual enviamos el path del URL por argumento, obtenemos el apiURL desde el Enviroment
    final resp = await http.get( uri,
    //Headers de la petición
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
  
    //Mapeamos la respuesta, donde obtenemos el JSON en el  resp.body
    final mensajesResp = messagesResponseFromJson(resp.body);

    return mensajesResp.messages;
  }
  
}