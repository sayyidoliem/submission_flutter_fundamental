import 'package:dicoding_submission_flutter_fundamental/presentation/provider/restaurant_state.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_submission_flutter_fundamental/data/api/api_service.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant_response.dart';

class RestaurantProvider with ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  late RestaurantResponse _restaurantResponse;
  RestaurantState _state = RestaurantState.loading;
  String _message = '';

  RestaurantResponse get result => _restaurantResponse;
  RestaurantState get state => _state;
  String get message => _message;

  Future<void> fetchAllRestaurants() async {
    try {
      _state = RestaurantState.loading;
      notifyListeners();

      final restaurantList = await apiService.getRestaurantList();
      if (restaurantList.restaurants.isEmpty) {
        _state = RestaurantState.empty;
        _message = 'No Data Available';
      } else {
        _state = RestaurantState.loaded;
        _restaurantResponse = restaurantList;
      }
      notifyListeners();
    } catch (e) {
      _state = RestaurantState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}

// import 'package:dicoding_submission_flutter_fundamental/provider/restaurant_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<RestaurantProvider>(
//         builder: (context, provider, _) {
//           switch (provider.state) {
//             case ResultState.loading:
//               return const Center(child: CircularProgressIndicator());
//             case ResultState.hasData:
//               final restaurants = provider.result.restaurants;
//               return ListView.separated(
//                 itemCount: restaurants.length,
//                 separatorBuilder: (context, index) => const Divider(),
//                 itemBuilder: (context, index) {
//                   final restaurant = restaurants[index];
//                   return ListTile(
//                     leading: SizedBox(
//                       width: 60,
//                       height: 60,
//                       child: Image.network(
//                         'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
//                       ),
//                     ),
//                     title: Text('${restaurant.name} | Kota ${restaurant.city}'),
//                     subtitle: Text(
//                       restaurant.description,
//                       maxLines: 1,
//                       overflow: TextOverflow.clip,
//                     ),
//                     trailing: Text(restaurant.rating.toString()),
//                     onTap: () {},
//                   );
//                 },
//               );
//             case ResultState.noData:
//             case ResultState.error:
//               return Center(child: Text(provider.message));
//           }
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:dicoding_submission_flutter_fundamental/data/api/api_service.dart';
// import 'package:dicoding_submission_flutter_fundamental/provider/restaurant_provider.dart';
// import 'package:dicoding_submission_flutter_fundamental/ui/home_page.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => RestaurantProvider(apiService: ApiService()),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Restaurant App',
//       theme: ThemeData(
//         primarySwatch: Colors.deepOrange,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
