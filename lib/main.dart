import 'package:flutter/material.dart';
//Routes
import 'package:chat_app/routes/routes.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      //Ruta inicial, encargada de verificar que el usuario ya está o no autenticado, para mandarlo a distintas pages
      initialRoute: 'chat',
      routes: appRoutes,
    );
  }
}