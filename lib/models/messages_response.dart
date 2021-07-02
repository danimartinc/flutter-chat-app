// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

MessagesResponse messagesResponseFromJson(String str) => MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) => json.encode(data.toJson());

class MessagesResponse {

  bool ok;
  List<Message> messages;

  //Constructor
  MessagesResponse({
    required this.ok,
    required this.messages,
  });



  factory MessagesResponse.fromJson(Map<String, dynamic> json) => MessagesResponse(
    ok: json["ok"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class Message {

    String from;
    String messageFor;
    String message;
    DateTime createdAt;
    DateTime updatedAt;

    //Constructor
    Message({
      required this.from,
      required this.messageFor,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
    });



    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        messageFor: json["for"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "for": messageFor,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
