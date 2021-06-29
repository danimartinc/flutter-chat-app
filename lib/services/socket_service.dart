import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app/global/environment.dart';
import 'auth_service.dart';

//Permite manejar los status del Server, y conocer el estado de los Sockets
enum ServerStatus {
  Online,
  Offline,
  Connecting
}

//Nos permite expandir la comunicación con el Servidor en cualquier punto de la app
//ChangeNotifier, permite indicar al Provider cuando tiene que refrescar la interfaz o volver a renderizar un componente, si se produce algún cambio o se quiere notificar a los clientes
class SocketService with ChangeNotifier {

  //Propiedad para controlar el Status en el acceso, por defecto establecemos que se encuentra en Connecting
  //En la primera conexión, no sabemos si el usuario está offline/online
  ServerStatus _serverStatus = ServerStatus.Connecting;
  //Al definir la propiedad privada nos permite controlar como mostramos el socket al resto de la app
  late IO.Socket _socket;

  //Get para utilizar la propiedad privada de serverStatus
  ServerStatus get serverStatus => this._serverStatus;
  //Nos permite exponer el Socket
  IO.Socket get socket => this._socket;
  //Función que permite emitir un Socket
  Function get emit    => this._socket.emit;

  //Constructor
  SocketService(){
    this._initConfig();
  }

  void _initConfig() async {

    final token = await AuthService.getToken();
    
    // Dart client
    this._socket = IO.io( Environment.socketURL, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });

    //Estado conectado
    this._socket.onConnect( (_) {
      //Indicamos el Status del Servidor
      this._serverStatus = ServerStatus.Online;
      print('Conectado por Socket');
      notifyListeners();
    });

    // Estado Desconectado
    this._socket.onDisconnect( (_) {
      //Indicamos el Status del Servidor
      this._serverStatus = ServerStatus.Offline;
      print('Desconectado del Socket Server');
      notifyListeners();
    });

  }


  void disconnect() {
    this._socket.disconnect();
  }

}