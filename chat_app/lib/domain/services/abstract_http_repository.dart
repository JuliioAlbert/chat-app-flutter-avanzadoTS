import 'package:chat_app/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:http/http.dart';

abstract class AbstractAuthRepository {
  Future<Response?> login(String email, String password);

  Future<Response?> register(String name, String email, String password);

  Future<Response?> isLoggedIn(String token);
}
