import 'dart:convert';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant.dart';

class RestaurantResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantResponse.fromRawJson(String str) =>
      RestaurantResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<Restaurant>.from(restaurants.map((x) => x.toJson())),
  };
}
