import 'package:submission_flutter_fundamental/import.dart';

class Menus {
  List<Food>? foods;
  List<Drink>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? []
            : List<Food>.from(json["foods"]!.map((x) => Food.fromJson(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Drink>.from(json["drinks"]!.map((x) => Drink.fromJson(x))),
      );
}