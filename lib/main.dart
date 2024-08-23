import 'package:appscrip_pract/data/repositories/user_repository.dart';
import 'package:appscrip_pract/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/home/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRoute = AppRoute();
    return BlocProvider(
      create: (context) => UserBloc(UserRepository()),
      child: MaterialApp.router(
        routerConfig: appRoute.router,
        theme: ThemeData(),
      ),
    );
  }
}
