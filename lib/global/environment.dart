import 'dart:io';

//Métodos estáticos, a los cuales puedo acceder sin necesidad de instanciar la clase
class Environment {
  //Accedemos a un server distinto dependiendo del dispositivo donde desplegamos la app, disponemos de dos endpoint distintos
  static String apiURL    = Platform.isAndroid ? 'http://192.168.1.36:3000/api' : 'http://localhost:3000/api';
  //Referencia tan solo al servidor, para conocer cual es el socket Server
  static String socketURL = Platform.isAndroid ? 'http://192.168.1.36:3000'     : 'http://localhost:3000';
}