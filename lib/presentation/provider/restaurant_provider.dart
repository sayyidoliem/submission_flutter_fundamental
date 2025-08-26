import 'package:flutter/material.dart';
import 'package:dicoding_submission_flutter_fundamental/data/api/api_service.dart';
import 'package:dicoding_submission_flutter_fundamental/data/model/restaurant_response.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/network_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService _api;

  RestaurantProvider(this._api);

  NetworkState<RestaurantResponse> listState = const Idle();
  NetworkState<RestaurantResponse> detailState = const Idle();
  NetworkState<RestaurantResponse> searchState = const Idle();

  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void setSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  Future<void> fetchRestaurants() async {
    listState = const Loading();
    notifyListeners();
    try {
      final resp = await _api.getRestaurantList();
      listState = Success(resp);
    } catch (e) {
      listState = Failure('Gagal memuat daftar restoran', e);
    }
    notifyListeners();
  }

  Future<void> fetchRestaurantDetail(String id) async {
    detailState = const Loading();
    notifyListeners();
    try {
      final resp = await _api.getDetailRestaurant(id);
      detailState = Success(resp);
    } catch (e) {
      detailState = Failure('Gagal memuat detail restoran', e);
    }
    notifyListeners();
  }

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      searchState = const Idle();
      notifyListeners();
      return;
    }

    searchState = const Loading();
    notifyListeners();
    try {
      final resp = await _api.searchRestaurant(query);
      searchState = Success(resp);
    } catch (e) {
      searchState = Failure('Gagal mencari restoran', e);
    }
    notifyListeners();
  }
}
