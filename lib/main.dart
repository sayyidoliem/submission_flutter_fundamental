import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/data/api/api_service.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/page/bookmark_page.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/page/detail_page.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/page/home_page.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/page/setting_page.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/bookmark_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/reminder_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/restaurant_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider(ApiService())),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ReminderProvider(ApiService())),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final router = GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          name: HOME_PAGE_ROUTE,
          path: '/',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          name: DETAIL_PAGE_ROUTE,
          path: '/detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DetailPage(id: id);
          },
        ),
        GoRoute(
          name: BOOKMARK_PAGE_ROUTE,
          path: '/bookmark',
          builder: (context, state) => BookmarkPage(),
        ),
        GoRoute(
          name: SETTING_PAGE_ROUTE,
          path: '/setting',
          builder: (context, state) => SettingPage(),
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.merriweatherTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.merriweatherTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
      ),
      themeMode: themeProvider.themeMode,
    );
  }
}
