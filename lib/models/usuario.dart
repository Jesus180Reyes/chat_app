// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.id,
    required this.nombre,
    required this.email,
    required this.password,
    required this.isOnline,
    required this.createdAt,
    required this.updatedAt,
    this.v,
  });

  final String? id;
  final String nombre;
  final String email;
  final String password;
  final bool isOnline;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? v;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
        isOnline: json["online"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "email": email,
        "password": password,
        "online": isOnline,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
