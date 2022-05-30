import 'dart:convert';

import 'package:chat_app/global/enviroments.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {
  Usuario? usuario;
  final storage = const FlutterSecureStorage();

  bool _autenticando = false;
  bool get autenticando => _autenticando;
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  Future login({required String email, required String password}) async {
    autenticando = true;

    final data = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse(
        '${Envirement.apiUrl}/login',
      ),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (resp.statusCode == 200) {
      final loginRespnse = loginResponseFromJson(resp.body);
      usuario = loginRespnse.usuario;
      await _guardarToken(loginRespnse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register({
    required String nombre,
    required String email,
    required String password,
    required String createdAt,
    required String updatedAt,
  }) async {
    autenticando = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };

    final resp = await http.post(
      Uri.parse(
        '${Envirement.apiUrl}/login/new',
      ),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (resp.statusCode == 200) {
      final loginRespnse = loginResponseFromJson(resp.body);
      usuario = loginRespnse.usuario;
      await _guardarToken(loginRespnse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future _guardarToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    await storage.delete(key: 'token');
  }

  Future<bool?> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    final resp = await http.get(
      Uri.parse(
        '${Envirement.apiUrl}/login/renew',
      ),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token!,
      },
    );
    if (resp.statusCode == 200) {
      final loginRespnse = loginResponseFromJson(resp.body);
      usuario = loginRespnse.usuario;
      await _guardarToken(loginRespnse.token);

      return true;
    } else {
      logOut();
    }
  }
}
