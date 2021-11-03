import 'package:chat_app/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/ui/pages/login/login_page.dart';
import 'package:chat_app/ui/pages/usuario/usuario_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(IsLoggedIn());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.session == TypeSession.Activa &&
            state.usuario != null &&
            state.autenticado == true) {
          // Navigator.popAndPushNamed(context, 'usuarios');
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const UsuariosPage(),
              transitionDuration: const Duration(milliseconds: 0),
            ),
          );
        }
        if (state.session == TypeSession.Close && state.autenticado == false) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionDuration: const Duration(milliseconds: 0),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                strokeWidth: 10,
                semanticsLabel: "Cargando",
              ),
              SizedBox(height: 30),
              const Text('LoadingPage'),
            ],
          ),
        ),
      ),
    );
  }
}
