import 'dart:convert';

import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantResponse> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail list');
    }
  }

  Future<RestaurantResponse> searchRestaurant(String value) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$value'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant search result');
    }
  }
}
