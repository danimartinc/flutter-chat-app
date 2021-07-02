import 'package:flutter/material.dart';
//Pages
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/users_page.dart';


//Map que contiene un string como key y contiene datos de tipo dynamic
//WidgetBuilder, dado que es una función que retorna un Widget
final Map<String, Widget Function(BuildContext)> appRoutes = {

  //Rutas principales de la app
  'users'    : ( _ ) => UsersPage(),
  'chat'     : ( _ ) => ChatPage(),
  'login'    : ( _ ) => LoginPage(),
  'register' : ( _ ) => RegisterPage(),
  'loading'  : ( _ ) => LoadingPage(),

};



//CORS, peticiones CROSS domain

//Provider encargado de cargar los mensajes del chat cuando el usuario accede al ChatPage, nos permite conocer a qué usuario le envio el chat, mediante el UID del usuario