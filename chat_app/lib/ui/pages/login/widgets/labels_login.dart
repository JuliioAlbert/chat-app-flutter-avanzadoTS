import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({
    Key? key,
    required this.ruta,
    required this.mensaje,
    required this.btnTitulo,
  }) : super(key: key);

  final String ruta;
  final String mensaje;
  final String btnTitulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            mensaje,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            child: Text(
              btnTitulo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.pushReplacementNamed(context, ruta),
          ),
        ],
      ),
    );
  }
}
