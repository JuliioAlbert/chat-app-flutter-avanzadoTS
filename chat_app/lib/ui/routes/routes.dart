import 'package:chat_app/ui/pages/chat/chat_page.dart';
import 'package:chat_app/ui/pages/loading/loading_page.dart';
import 'package:chat_app/ui/pages/login/login_page.dart';
import 'package:chat_app/ui/pages/register/register_page.dart';
import 'package:chat_app/ui/pages/usuario/usuario_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuario': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage()
};
