import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presentation/screens/home/home_screen.dart';

class AppRoute {
  final GoRouter router = GoRouter(initialLocation: '/', routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
  ]);
}
