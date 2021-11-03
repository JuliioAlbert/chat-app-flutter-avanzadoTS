import 'package:chat_app/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/ui/pages/login/widgets/labels_login.dart';
import 'package:chat_app/ui/widgets/btn_rojo.dart';
import 'package:chat_app/ui/widgets/custom_input.dart';
import 'package:chat_app/ui/widgets/logo.dart';
import 'package:chat_app/ui/widgets/mostrar_alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.autenticado == false &&
            state.autenticando == false &&
            state.serverError != null) {
          MostrarAlerta.mostrarAlerta(
              context, 'Registro Incorrecto', state.serverError!);
        }
        if (state.autenticado == true && state.autenticando == false) {
          Navigator.pushReplacementNamed(context, 'usuarios');
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Logo(titulo: 'Register'),
                  Formulario(),
                  Labels(
                    ruta: 'login',
                    btnTitulo: 'Inicia Sesión',
                    mensaje: '¿Ya tienes cuenta?',
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
        );
      },
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
  final TextEditingController nomCtrl = TextEditingController();

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
            controller: nomCtrl,
            icon: CupertinoIcons.person_crop_circle_fill,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
          ),
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
                label: "Registrar",
                onPressed: state.autenticando
                    ? null
                    : () {
                        BlocProvider.of<AuthBloc>(context).add(Register(
                            nomCtrl.text, emailCtrl.text, pswCtrl.text));
                      },
              );
            },
          )
        ],
      ),
    );
  }
}
