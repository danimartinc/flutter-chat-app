import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/environment.dart';
//Storage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//Models
import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/login_response.dart';


//Nos permite expandir la comunicación con el Servidor en cualquier punto de la app, se puede utilziar de forma global
//ChangeNotifier, permite indicar al Provider cuando tiene que refrescar la interfaz o volver a renderizar un componente, si se produce algún cambio o se quiere notificar a los clientes
class AuthService with ChangeNotifier {

  //Información del usuario autenticado
  User? user;
  //Nos indica cuando el usuario está realizando la autenticación
  bool _authenticating = false;
  
  //Instancia del Storage
  final _storage = new FlutterSecureStorage();

  //Getter para obtener el valor de _authenticating
  bool get authenticating => this._authenticating;

  //Setter, para modificar el valor del _authenticating
  set authenticating( bool value ) {
    this._authenticating = value;
    //Debemos notificar cuando se modifique el valor a los Widgets que estén escuchando el AuthService, 
    notifyListeners();
  }

  //Getter del Token de forma estática, para acceder al Token de forma global a través del AuthService
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    //Leemos la información del Token para obtenerlo
    final token = await _storage.read(key: 'token');
    return token;
  }

  //Setter para eliminar el JWT
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }
  
  //Método asíncrono que retorna un Future, que nos permite realizar el login del Usuario
  //Devuelve un boolean, true si es correcto y false si es incorrecto
  Future<bool> login( String email, String password ) async {
    
    this.authenticating = true;

    //payload que tenemos que enviar al Backend
    final data = {
      'email': email,
      'password': password
    };

    //Endpoint para realizar el Login
    final uri = Uri.parse('${ Environment.apiURL }/login');

    //Mapear la respuesta al modelo de tipo Usuario
    //Petición POST, en la cual enviamos el path del URL por argumento, obtenemos el apiURL desde el Enviroment
    final resp = await http.post( uri,
      //Mediante jsonEncode() enviamos en el body el payload de la data en JSON
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print( resp.body );

    //Establecemos el state de la autenticación en false indicando que el proceso ha finalizado
    this.authenticating = false;

    //Compruebo si la petición se realiza correctamente, ya que si no, no se va a poder generar el Map
    
    //En el caso de que la petición se realice correctamente, es decir devuelva un status 200 el server, 
    if ( resp.statusCode == 200 ) {
      //Guardo la respuesta del loginResponseFromJson del usuario
      final loginResponse = loginResponseFromJson( resp.body );
      //Almaceno en el usuario la loginResponse del servidor, cuando la autenticación es válida
      this.user = loginResponse.user;

      //Guardamos el JWT en un lugar persistente del dispositivo
      await this._saveToken( loginResponse.token );
      return true;
    }else{
      //En caso de que no se obtenga la loginResponse
      return false;
    }

  }

  //Método para realizar el registro del usuario
  Future register( String name, String email, String password ) async {

    this.authenticating = true;

    final data = {
      'name': name,
      'email': email,
      'password': password
    };

    //Endpoint para realizar el registro de un nuevo usuario
    final uri = Uri.parse('${ Environment.apiURL }/login/new');
    
    //Petición POST, en la cual enviamos el path del URL por argumento, obtenemos el apiURL desde el Enviroment
    final resp = await http.post( uri,
      //Mediante jsonEncode() enviamos en el body el payload de la data en JSON
      body: jsonEncode(data),
      headers: { 'Content-Type': 'application/json' }
    );

    this.authenticating = false;

    //En el caso de que la petición se realice correctamente, es decir devuelva un status 200 el server, 
    if ( resp.statusCode == 200 ) {
      //Guardo la respuesta del loginResponseFromJson del usuario
      final loginResponse = loginResponseFromJson( resp.body );
      //Almaceno en el usuario la loginResponse del servidor, cuando la autenticación es válida
      this.user = loginResponse.user;

      //Guardamos el JWT en un lugar persistente del dispositivo
      await this._saveToken( loginResponse.token );
      return true;
    }else{
      //En caso de que no se obtenga la loginResponse
      //Mapear la respuesta al modelo de tipo Usuario
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  //Método para verificar el JWT almacenado en el Storage y verificar contra el Backend si sigue siendo un Token válido
  Future<bool> isLoggedIn () async {

    //Leemos el Token desde el Storage
    String? token = await this._storage.read(key: 'token');

    if( token == null ){
      token = '';
    }

    //Endpoint para obtener un Token renovado
    final uri = Uri.parse('${ Environment.apiURL }/login/renew');

    final resp = await http.get( uri, 
      headers: { 
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    //En el caso de que la petición se realice correctamente, es decir devuelva un status 200 el server, 
    if ( resp.statusCode == 200 ) {
      //Guardo la respuesta del loginResponseFromJson del usuario
      final loginResponse = loginResponseFromJson( resp.body );
      //Almaceno en el usuario la loginResponse del servidor, cuando la autenticación es válida
      this.user = loginResponse.user;

      //Guardamos el JWT en un lugar persistente del dispositivo
      await this._saveToken( loginResponse.token );
      return true;
    }else{
      //En caso de que no se obtenga la loginResponse
      //Realizo el borrado del Token ya que no es válido
      this.logout();
      return false;
    }

  }

  Future _saveToken( String token ) async {
    //Nos permite guardar el JWT en el Storage
    return await _storage.write(key: 'token', value: token );
  }
  
  Future logout() async {
    //En el proceso de logout, elimino el JWT que se encuentra en la propiedad Token del Storage
    await _storage.delete(key: 'token');
  }

}