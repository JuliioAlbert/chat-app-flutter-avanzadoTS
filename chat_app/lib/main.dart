import 'package:chat_app/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/domain/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_app/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependencyInyection/dependency_inyection.dart';

void main() {
  DependencyInyection.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(create: (_) => ChatBloc()),
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'loading',
      routes: appRoutes,
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.grey[900],
      ),
    );
  }
}
