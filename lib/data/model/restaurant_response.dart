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

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        error: json["error"],
        message: json["message"] ?? '',
        count: json["count"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
