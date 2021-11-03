// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chat_app/data/services/auth_repository.dart';
import 'package:chat_app/domain/entities/login_response.dart';
import 'package:chat_app/domain/entities/usuario.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = GetIt.instance<AuthRepository>();
  final _storage = GetIt.instance<FlutterSecureStorage>();

  Usuario? get usuario => state.usuario;

  static Future<String?> token() async {
    final _storage = GetIt.instance<FlutterSecureStorage>();
    return await _storage.read(key: 'token');
  }

  static Future<void> deteleToken() async {
    final _storage = GetIt.instance<FlutterSecureStorage>();
    return await _storage.delete(key: 'token');
  }

  AuthBloc() : super(AuthState()) {
    on<AuthEvent>((event, emit) {
      if (event is Login) {
        login(event.email, event.password);
      } else if (event is Register) {
        register(event.name, event.email, event.password);
      } else if (event is IsLoggedIn) {
        isLoggedIn();
      } else if (event is Loggout) {
        _logout();
      }
    });
  }

  Future isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    if (token == null) return emit(state.copyWith(session: TypeSession.Close));
    final response = await _authRepository.isLoggedIn(token);
    if (response != null) {
      if (response.statusCode == 200) {
        final loginResponse = loginReponseFromJson(response.body);
        await _guardarToken(loginResponse.token);
        return emit(state.copyWith(
          usuario: loginResponse.usuarioDb,
          autenticado: true,
          session: TypeSession.Activa,
        ));
      }
      return emit(state.copyWith(
        autenticado: false,
        autenticando: false,
        session: TypeSession.Close,
        serverError: jsonDecode(response.body)['msj'],
      ));
    }
  }

  Future<void> register(String name, String email, String password) async {
    final response = await _authRepository.register(name, email, password);
    if (response != null) {
      if (response.statusCode == 200) {
        final loginResponse = loginReponseFromJson(response.body);
        await _guardarToken(loginResponse.token);
        return emit(state.copyWith(
            usuario: loginResponse.usuarioDb, autenticado: true));
      }
      return emit(
        state.copyWith(
            autenticado: false,
            autenticando: false,
            serverError: jsonDecode(response.body)["msj"]),
      );
    }
    return emit(state.copyWith(autenticando: false, autenticado: false));
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(autenticando: true));
    final response = await _authRepository.login(email, password);
    if (response != null) {
      if (response.statusCode == 200) {
        final loginResponse = loginReponseFromJson(response.body);
        await _guardarToken(loginResponse.token);
        return emit(state.copyWith(
            usuario: loginResponse.usuarioDb, autenticado: true));
      }
      return emit(state.copyWith(autenticado: false, autenticando: false));
    }
    return emit(state.copyWith(autenticando: false, autenticado: false));
  }

  Future<void> _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logout() async {
    return await _storage.delete(key: 'token');
  }
}
