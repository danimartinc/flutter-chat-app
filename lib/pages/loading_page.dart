import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//Providers
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
//Pages
import 'package:chat_app/pages/users_page.dart';
import 'login_page.dart';

//Preloading de la app, ya que mantiene toda la información en memoria, mantengo información persistente
//Nos permite conocer si el usuario tiene un JWT válido, si es válido redirigo hacia users, en caso de que no lo sea redirigo al login
class LoadingPage extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //Disparo el future
        future: checkLoginState(context),
        //Disparamos el Future mediante el builder
        builder: ( context, snapshot) {
          return Center(
            //TODO: Animation
                child: Text('Espere...'),
          );
        },
        
      ),
   );
  }

  //Método para comprobar el estado de la autenticación
  Future checkLoginState( BuildContext context ) async {

    //Obtenemos el authService, mediante la instancia de Provider
    final authService = Provider.of<AuthService>(context, listen: false);
    //Implemetamos el socketService
    final socketService = Provider.of<SocketService>( context, listen: false );

    //Nos llamar a isLoggedIn(), para verificar el JWT almacenado en el Storage y verificar contra el Backend si sigue siendo un Token válido
    final authenticated = await authService.isLoggedIn();

    if ( authenticated ) {
      //En el caso de que sea una autenticación válida, con un JWT válido, me conecto al SocketServer
      socketService.connect();
      //Redirigo al UsersPage en el caso de que el usuario esté autenticado correctamente
      Navigator.pushReplacement(
        context,
        //Defino una nueva ruta mediante PageRouteBuilder()
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => UsersPage(),
          //TODO: Cambiar animación
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    } else {
      //Redirigo al Login en el caso de que el usuario NO esté autenticado correctamente
      Navigator.pushReplacement(
        context,
        //Defino una nueva ruta mediante PageRouteBuilder()
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    }

  }

  
}