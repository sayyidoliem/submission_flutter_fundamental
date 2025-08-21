import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/page/detail_page.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          name: HOME_PAGE_ROUTE,
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: DETAIL_PAGE_ROUTE,
          path: '/detail',
          builder: (context, state) {
            final params = state.extra as Restaurant;
            return DetailPage(data: params);
          },
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
