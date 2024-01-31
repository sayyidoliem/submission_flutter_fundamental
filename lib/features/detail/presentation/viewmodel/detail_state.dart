part of 'detail_bloc.dart';

sealed class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailSuccess extends DetailState {
  final List<RestaurantElement> restaurant;

  DetailSuccess({required this.restaurant});
}

class DetailError extends DetailState {}
