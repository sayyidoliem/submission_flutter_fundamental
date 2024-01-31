part of 'home_bloc.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<RestaurantElement> restaurant;

  HomeSuccess({required this.restaurant});
}

class HomeError extends HomeState {}
