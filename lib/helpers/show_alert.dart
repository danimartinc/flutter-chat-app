import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Función para mostrar una alerta
showAlert( BuildContext context, String title, String subtitle ) {

  //En caso de que el dispositivo sea Android
  if ( Platform.isAndroid ) {
    return showDialog(
      context: context,
      builder: ( _ ) => AlertDialog(
        title: Text( title ),
        content: Text( subtitle ),
        actions: <Widget>[
          MaterialButton(
            child: Text('Aceptar'),
            elevation: 5,
            textColor: Colors.blue,
            //Dispara el Navigator.pop() para cerrar el Dialog
            onPressed: () => Navigator.pop(context)
          )
        ],
      )
    );
  }
  //En caso de que el dispositivo sea IOs
  showCupertinoDialog(
    context: context, 
    builder: ( _ ) => CupertinoAlertDialog(
      title: Text( title ),
      content: Text( subtitle ),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Aceptar'),
          //Dispara el Navigator.pop() para cerrar el Dialog
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
  );
  
}