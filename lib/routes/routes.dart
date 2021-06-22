import 'package:flutter/material.dart';
//Pages
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/users_page.dart';


//Map que contiene un string como key y contiene datos de tipo dynamic
//WidgetBuilder, dado que es una función que retorna un Widget
final Map<String, WidgetBuilder> appRoutes = {

  //Rutas principales de la app
  'users'    : ( _ ) => UsersPage(),
  'chat'     : ( _ ) => ChatPage(),
  'login'    : ( _ ) => LoginPage(),
  'register' : ( _ ) => RegisterPage(),
  'loading'  : ( _ ) => LoadingPage(),

};