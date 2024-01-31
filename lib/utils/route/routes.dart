import 'package:submission_flutter_fundamental/import.dart';

class MyRoute {
  Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomePage(),
        );
      case RoutesName.detail:
      final args = settings.arguments as Map<String, dynamic>;
      final index = args['id'] as int;
        return MaterialPageRoute(
          builder: (context) => DetailPage(index: index,),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ErrorPage(),
        );
    }
  }
}
