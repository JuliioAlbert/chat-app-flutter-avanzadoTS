import 'package:chat_app/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/domain/entities/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final usuario = context.read<AuthBloc>().usuario;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(usuario?.nombre.toUpperCase() ?? "Sin nombre"),
          leading: IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(Loggout());
              Navigator.pushReplacementNamed(context, 'login');
              //Disconnect
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          actions: [
            CupertinoButton(
                child: const Icon(Icons.online_prediction), onPressed: () {})
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: onRefresh,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.grey[500]),
            waterDropColor: Colors.grey,
          ),
          child: ListUsuarios(),
        ));
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

class ListUsuarios extends StatelessWidget {
  final usuarios = [
    Usuario(
      uid: '1',
      nombre: "julio",
      email: "correo@correo.com",
      online: true,
    ),
    Usuario(
      uid: '2',
      nombre: "Diego",
      email: "correo2@correo.com",
      online: true,
    ),
    Usuario(
      uid: '3',
      nombre: "Fernando",
      email: "correo1@correo.com",
      online: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, int i) {
        return UsuarioAvatar(usuario: usuarios[i]);
      },
      itemCount: usuarios.length,
      separatorBuilder: (_, i) => Divider(),
    );
  }
}

class UsuarioAvatar extends StatelessWidget {
  const UsuarioAvatar({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(usuario.nombre),
      leading: CircleAvatar(
        //backgroundColor: Colors.grey[600],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      subtitle: Text(usuario.email),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.red : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
