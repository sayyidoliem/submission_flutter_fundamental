import 'package:dicoding_submission_flutter_fundamental/data/model/drink.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/food.dart';

class Menu {
  List<Food>? foods;
  List<Drink>? drinks;

  Menu({
    this.foods,
    this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: json["foods"] == null
            ? []
            : List<Food>.from(json["foods"]!.map((x) => Food.fromJson(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Drink>.from(json["drinks"]!.map((x) => Drink.fromJson(x))),
      );
}