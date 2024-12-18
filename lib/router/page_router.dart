import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/main_page/presentation/pages/main_page.dart';

final rootNavigationKey = GlobalKey<NavigatorState>();

class MyPageRouter{
  GoRouter get myRouter => _myRouter;
  static final _myRouter = GoRouter(
    // initialLocation: '/show_skate_spots_page/:uid',
    navigatorKey: rootNavigationKey,
    routes: <RouteBase>[
  GoRoute(
  name: 'main_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/',
    builder: (context, state) => const MainPage(),
  ),
]);
}