import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';
import 'auth_service.dart';
//Models
import 'package:chat_app/models/users_response.dart';
import 'package:chat_app/models/user.dart';


//Provider para centralizar peticiones HTTP hacia el endpoint /api/users
class UsersService {

  //Método que devuelve una Lista de usuarios mediante un Future
  Future<List<User>> getUsers() async {

    try {
      //Obtenemos el JWT desde el authService
      String? token = await AuthService.getToken();

      if( token == null ){
        token = '';
      }

      //Endpoint para obtener el listado de usuarios
      final uri = Uri.parse('${ Environment.apiURL }/users');

      //Petición GET, en la cual enviamos el path del URL por argumento, obtenemos el apiURL desde el Enviroment
      final resp = await http.get( uri,
      //Headers de la petición
        headers: {
          'Content-Type': 'application/json',
          'x-token': token
        }
    
      );
      //Mapeamos la respuesta, donde obtenemos el JSON en el  resp.body
      final usersResponse = usersResponseFromJson( resp.body );

      return usersResponse.users;

    } catch (e) {
      //En caso de error, devolvemos un array vacio
      return [];
    }

  }


}