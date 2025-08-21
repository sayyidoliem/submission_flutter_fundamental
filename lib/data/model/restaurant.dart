import 'dart:convert';

import 'package:dicoding_submission_flutter_fundamental/data/model/category.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/customer_review.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String? address;
  final String pictureId;
  final List<Category>? categories;
  final Menus? menus;
  final double rating;
  final List<CustomerReview>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    address: json["address"],
    pictureId: json["pictureId"],
    categories: json["categories"] == null
        ? []
        : List<Category>.from(
            json["categories"]!.map((x) => Category.fromJson(x)),
          ),
    menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
    rating: json["rating"]?.toDouble(),
    customerReviews: json["customerReviews"] == null
        ? []
        : List<CustomerReview>.from(
            json["customerReviews"]!.map((x) => CustomerReview.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "menus": menus?.toString(),
    "rating": rating,
    "customerReviews": customerReviews == null
        ? []
        : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
  };
}
