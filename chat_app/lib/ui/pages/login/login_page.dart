import 'package:chat_app/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/ui/widgets/btn_rojo.dart';
import 'package:chat_app/ui/widgets/custom_input.dart';
import 'package:chat_app/ui/widgets/logo.dart';
import 'package:chat_app/ui/widgets/mostrar_alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/labels_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Logo(titulo: 'Messagin'),
              Formulario(),
              Labels(
                ruta: 'register',
                btnTitulo: '¿Crear una cuenta?',
                mensaje: 'No tienes cuenta?',
              ),
              Text(
                "Terminos y condiciones de Uso",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController pswCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            controller: emailCtrl,
            icon: CupertinoIcons.mail,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            isPassword: true,
            controller: pswCtrl,
            icon: CupertinoIcons.lock,
            placeholder: 'Password',
            keyboardType: TextInputType.text,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ButtonRojo(
                label: "Ingresar",
                onPressed: state.autenticando
                    ? null
                    : () {
                        FocusScope.of(context)
                            .unfocus(); // Quitar el foco de atencion

                        BlocProvider.of<AuthBloc>(context)
                            .add(Login(emailCtrl.text, pswCtrl.text));
                        if (state.autenticado && state.autenticando == false) {
                          //TODO:"Conectar SOCKET"
                          Navigator.pushReplacementNamed(context, 'usuarios');
                        } else {
                          MostrarAlerta.mostrarAlerta(context, 'Login error',
                              "Revise sus credenciales");
                        }
                      },
              );
            },
          )
        ],
      ),
    );
  }
}
