import 'package:flutter/material.dart';
//Widgets
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/blue_btn.dart';

//Widget para controlar el formulario de la page de Register
class RegisterPage extends StatelessWidget {

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
                Logo( title: 'Registro' ),
                _Form(),
               //Indicamos la ruta hacia el LoginPage
                Labels( route: 'login', title: '¿Ya estás registrado?', subTitle: 'Iniciar sesión', ),
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

  final nameController     = TextEditingController();
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: [

          //CustomInput() del email
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            //nameController, permite obtener la información del Input del email
            textController: nameController,
          ),
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
            onPressed: (){
              print( emailController.text );
              print( passwordController.text );
            },
          )      
    ]  
  ),
  );

  }

}

