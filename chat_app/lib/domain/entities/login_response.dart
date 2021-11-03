// To parse this JSON data, do
//
//     final loginReponse = loginReponseFromJson(jsonString);

import 'dart:convert';

import 'usuario.dart';

LoginReponse loginReponseFromJson(String str) =>
    LoginReponse.fromJson(json.decode(str));

String loginReponseToJson(LoginReponse data) => json.encode(data.toJson());

class LoginReponse {
  LoginReponse({
    required this.ok,
    required this.usuarioDb,
    required this.token,
  });

  bool ok;
  Usuario usuarioDb;
  String token;

  factory LoginReponse.fromJson(Map<String, dynamic> json) => LoginReponse(
        ok: json["ok"],
        usuarioDb: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarioDB": usuarioDb.toJson(),
        "token": token,
      };
}
