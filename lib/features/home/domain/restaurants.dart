import 'package:submission_flutter_fundamental/import.dart';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

class Restaurant {
  List<RestaurantElement> restaurants;

  Restaurant({
    required this.restaurants,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        restaurants: List<RestaurantElement>.from(
            json["restaurants"].map((x) => RestaurantElement.fromJson(x))),
      );
}

class RestaurantElement {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  RestaurantElement({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantElement.fromJson(Map<String, dynamic> json) =>
      RestaurantElement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
      );
}
