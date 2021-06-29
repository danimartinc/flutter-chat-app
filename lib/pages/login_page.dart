import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//Providers
import 'package:chat_app/services/auth_service.dart';
//Widgets
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/blue_btn.dart';
//Helpers
import 'package:chat_app/helpers/show_alert.dart';


//Widget para controlar el formulario de la page de Login
class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        //SingleChildScrollView, evita que al abrir el teclado se compriman todos los elementos que hay en pantalla y realizar scroll en posición horizontal
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            //Indicamos que ocupe un 90% del alto que tenga disponible en la pantalla
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo( title: 'Messenger' ),
                _Form(),
                //Indicamos la ruta hacia el RegisterPage
                Labels( route: 'register', title: '¿No estás registrado?', subTitle: 'Crear una cuenta', ),
                Text('Términos y condiciones de uso', style:  TextStyle( fontWeight: FontWeight.w200 ),)
              ],
            ),
          ),
        ),
      ),
   );
  }
}



//Permite controlar el formulario mediante un Widget para implementar controladores
class _Form extends StatefulWidget {
  @override
   _FormState createState() =>  _FormState();
}

class  _FormState extends State<_Form> {

  final emailController    = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    //Implementamos el authService,
    //Es necesario renderizar el Widget si cambia el valor de la propeidad y disparar el notifyListeners()
    final authService = Provider.of<AuthService>( context );

    return Container(
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: <Widget>[
          //CustomInput() del email
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            //emailController, permite obtener la información del Input del email
            textController: emailController,
          ),

          //CustomInput() del password
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            //passwordController, permite obtener la información del Input del password
            textController: passwordController,
            isPassword: true,
          ),
          BlueButton(  
            text: 'Iniciar sesión',
            //Deshabilito el botón de Iniciar sesión, para que cuando el usuario se esté autenticando pueda volver a realizar el posteo
            //Mediante un operador ternario evaluo si el usuario se está autenticando mediante el boolean
            onPressed: authService.authenticating
                        //En caso de que se esté autenticando
                        ? () => null
                        : ()  async {
                          //Cuando el usuario selecciona el botón de Iniciar sesión, indicamos que se cierre el teclado
                          //Lo realizamos al quitar el focus sobre el teclado del dispositivo, y ocultamos el teclado
                          FocusScope.of(context).unfocus();
                          print('Entra al loginView');
                          print( emailController.text );
                          print( passwordController.text );
                          //Mediante trim() elimino los espacios en blanco
                          final loginOK = await authService.login( emailController.text.trim(), passwordController.text.trim() );

                          //Compruebo si la autenticación se ha realizado correctamente
                          if( loginOK ){
                            //TODO: Conectar a Socsket server
                            //Mediante pushReplacementNamed() realizo un reemplazo del login, para evitar que el usuario pueda volver al login
                            Navigator.pushReplacementNamed( context, 'users' );
                          }else{
                            // TODO: Mostrar alerta
                            showAlert( context, 'Login incorrecto', 'Compruebe si sus credenciales son correctas');
                          }
                        },
          )      
        ],
      ),
    );

  }

}



  //Deshabilito el botón de Iniciar sesión, para que cuando el usuario se esté autenticando no pueda volver a realizar el posteo

     