import 'package:chat_app/ui/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'login',
      routes: appRoutes,
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.grey[900],
      ),
    );
  }
}
