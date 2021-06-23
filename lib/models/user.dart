//Modelo para definir el tipo Usuario

// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

User usuarioFromJson(String str) => User.fromJson(json.decode(str));

String usuarioToJson(User data) => json.encode(data.toJson());

class User {

    String uid;
    String name;
    String email;
    bool online;
    

    User({
      required this.uid,
      required this.name,
      required this.email,
      required this.online,
    });


    factory User.fromJson(Map<String, dynamic> json) => User(
        online: json["online"],
        name: json["name"],
        email: json["email"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "name": name,
        "email": email,
        "uid": uid,
    };
}