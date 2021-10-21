import 'package:chat_app/domain/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_app/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<ChatBloc>(create: (_) => ChatBloc()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'chat',
      routes: appRoutes,
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.grey[900],
      ),
    );
  }
}
