import 'dart:convert';
import 'restaurant.dart';

class RestaurantResponse {
  final bool error;
  final String message;
  final int? count;
  final int? founded;
  final List<Restaurant> restaurants;

  RestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantResponse.fromRawJson(String str) =>
      RestaurantResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) {
    final bool error = json['error'] ?? false;
    final String message = json['message'] ?? '';
    final int? count = json['count'];
    final int? founded = json['founded'];

    List<Restaurant> restaurants = <Restaurant>[];

    if (json['restaurants'] is List) {
      restaurants = (json['restaurants'] as List)
          .map((x) => Restaurant.fromJson(x as Map<String, dynamic>))
          .toList();
    } else if (json['restaurant'] != null) {
      restaurants = [
        Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      ];
    } else {
      restaurants = <Restaurant>[];
    }

    return RestaurantResponse(
      error: error,
      message: message,
      count: count,
      founded: founded,
      restaurants: restaurants,
    );
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
