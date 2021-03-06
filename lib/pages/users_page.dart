import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//Providers
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/chat_Service.dart';
import 'package:chat_app/services/users_service.dart';
//Models
import 'package:chat_app/models/user.dart';




class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  //Instancia del getUsers del usersService()
  final userService = new UsersService();
  //Controller para el Pull to refresh
  RefreshController _refreshController = RefreshController( initialRefresh: false );

  //Listado de usuarios
  List<User> users = [];

  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //Instancia del Provider de authService
    final authService = Provider.of<AuthService>(context);
    //Implemetamos el socketService
    final socketService = Provider.of<SocketService>( context );
    //Extraemos el usuario desde el authService
    final user = authService.user;
    
    return Scaffold(
      appBar: AppBar(
        title: Text( user!.name, style: TextStyle( color: Colors.black87 ) ),
        elevation: 1,
        backgroundColor: Colors.white,
        //Icono para retroceder en la Page
        leading: IconButton(
          onPressed: () {
            //Desconectamos el cliente del SocketServer al realizar el logout
            socketService.disconnect();
            //Realizamos la navegación hacia el LoginPage
            Navigator.pushReplacementNamed( context, 'login' );
            //Eliminamos el JWT del usuario autenticado para realizar el logout al borrar su información
            AuthService.deleteToken();
          }, 
          icon: Icon( Icons.exit_to_app, color: Colors.black87 ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( right: 10 ),
            //Mediante un operador ternario muestro los iconos según el usuario esté conectado/deconectado, qué obtenemos desde el serverStatus
            child: ( socketService.serverStatus == ServerStatus.Online )
                      //Icono que muestra el estado de conexión con el chat
                      ? Icon( Icons.check_circle, color: Colors.blue[400] )
                      //Icono cuando el usuario se muestra desconectado
                      : Icon( Icons.offline_bolt, color: Colors.red ),
          )
        ],
      ),
      //ListView, listado de usuarios registrados en el chat
      body: SmartRefresher(
        controller: _refreshController,
        //Nos permite realziar el refresh al deslizar con el dedo hacía abajo
        enablePullDown: true,
        //Permite disparar la acción que se realiza cuando se produce el Pull to Refresh
        onRefresh: _loadUsers,
        //Personalización del refresh
        header: WaterDropHeader(
          complete: Icon( Icons.check, color: Colors.blue[400] ),
          waterDropColor: Colors.blue,
        ),
        //Widget que contruye tras el refresh
        child: _listViewUsers(),
      ),
   );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      //Animación con efecto de Bouncing en el ListView
      physics: BouncingScrollPhysics(),
      itemBuilder: ( _, i ) => _userListTile( users[i] ),
      //Divider() entre los elementos de la lista
      separatorBuilder: ( _, i ) => Divider(), 
      itemCount: users.length
    );
  }

  ListTile _userListTile( User user ) {
    return ListTile(
        title: Text( user.name ),
        subtitle: Text( user.email ),
        //Avatar para cada usuario
        leading: CircleAvatar(
          child: Text( user.name.substring( 0,2 ) ),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            //Color que se muestra cuando el usuario se muestra online
            color: user.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular( 100 ),
          ),
        ),
        onTap: () {
          //Implementamos el chatService
          final chatService = Provider.of<ChatService>(context, listen: false );
          //Muestro la información del usuario que recibe el mensaje mediante el chatService
          chatService.receivingUser = user;
          //Redirigo hacia el chatPage
          Navigator.pushNamed(context, 'chat');
        } ,
      );
  }

  //Método asíncrono que obtiene el listado de usuario desde un endpoint
  _loadUsers() async {
    
    //Establecemos que el listado de usuarios, es el que obtenemos al realizar la petición GET
    this.users = await userService.getUsers();

    setState(() { });
    
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
