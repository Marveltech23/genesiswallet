// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String status;
  String message;
  Data data;

  Welcome({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String phrase;

  Data({
    required this.phrase,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phrase: json["phrase"],
      );

  Map<String, dynamic> toJson() => {
        "phrase": phrase,
      };
}
