import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//Routes
import 'package:chat_app/routes/routes.dart';
//Providers
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';


 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //List de Provders
      providers: [
        ChangeNotifierProvider(
          //Instancia global del AuthService, que nos permite controlarlo como un Singleton, y notifica a los Widgets cuando es necesario volver a renderizar
          create: ( _ ) => AuthService()
        ),
        ChangeNotifierProvider(
          //Instancia global del SocketService, que nos permite controlarlo como un Singleton, y notifica a los Widgets cuando es necesario volver a renderizar
          create: ( _ ) => SocketService()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        //Ruta inicial, encargada de verificar que el usuario ya está o no autenticado, para mandarlo a distintas pages
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}