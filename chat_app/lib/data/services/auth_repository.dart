import 'dart:convert';

import 'package:chat_app/domain/services/abstract_http_repository.dart';
import 'package:chat_app/global/enviroment.dart';
import 'package:http/http.dart' as http;

class AuthRepository extends AbstractAuthRepository {
  @override
  Future<http.Response?> login(String email, String password) async {
    final url = Uri.parse("http://${Enviroment.apiUrl}/login");

    final data = {
      'email': email,
      'password': password,
    };

    try {
      return await http.post(url, body: json.encode(data), headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      return null;
    }
  }

  @override
  Future<http.Response?> register(
      String name, String email, String password) async {
    final url = Uri.parse("http://${Enviroment.apiUrl}/login/new");

    final data = {
      'nombre': name,
      'email': email,
      'password': password,
    };

    try {
      return await http.post(url, body: json.encode(data), headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      return null;
    }
  }

  @override
  Future<http.Response?> isLoggedIn(String token) async {
    final url = Uri.parse("http://${Enviroment.apiUrl}/login/renew");
    try {
      return await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
    } catch (e) {
      return null;
    }
  }
}
