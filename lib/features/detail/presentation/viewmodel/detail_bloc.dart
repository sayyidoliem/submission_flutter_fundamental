import 'package:submission_flutter_fundamental/import.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Cubit<DetailState> {
  DetailBloc() : super(DetailInitial());
  void getData() async {
    try {
      emit(DetailLoading());
      await Future.delayed(Duration(seconds: 1));
      String localData = await rootBundle.loadString("/local_restaurant.json");
      // print(localData);
      final result = restaurantFromJson(localData);
      emit(DetailSuccess(restaurant: result.restaurants));
    } catch (e) {
      emit(DetailError());
    }
  }
}
