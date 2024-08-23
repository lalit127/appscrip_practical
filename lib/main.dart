import 'package:appscrip_pract/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRoute = AppRoute();
    return MaterialApp.router(
      routerConfig: appRoute.router,
      theme: ThemeData(),
    );
  }
}
