import 'package:submission_flutter_fundamental/import.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitial());
  void getData() async {
    try {
      emit(HomeLoading());
      await Future.delayed(Duration(seconds: 1));
      String localData = await rootBundle.loadString("/local_restaurant.json");
      // print(localData);
      final result = restaurantFromJson(localData);
      emit(HomeSuccess(restaurant: result.restaurants));
    } catch (e) {
      emit(HomeError());
    }
  }
}