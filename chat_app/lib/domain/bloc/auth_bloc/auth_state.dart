part of 'auth_bloc.dart';

enum TypeSession {
  Activa,
  Close,
}

class AuthState {
  final Usuario? usuario;
  final bool autenticando;
  final bool autenticado;
  final String? serverError;
  final TypeSession session;

  AuthState({
    this.usuario,
    this.autenticando = false,
    this.autenticado = false,
    this.serverError,
    this.session = TypeSession.Close,
  });

  AuthState copyWith({
    Usuario? usuario,
    bool? autenticando,
    bool? autenticado,
    String? serverError,
    TypeSession? session,
  }) =>
      AuthState(
        usuario: usuario ?? this.usuario,
        autenticando: autenticando ?? this.autenticando,
        autenticado: autenticado ?? this.autenticado,
        serverError: serverError ?? this.serverError,
        session: session ?? this.session,
      );
}
