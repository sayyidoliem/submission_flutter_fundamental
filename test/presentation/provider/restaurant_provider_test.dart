import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/restaurant_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/data/api/api_service.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/network_state.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApi;
  late RestaurantProvider provider;

  setUp(() {
    mockApi = MockApiService();
    provider = RestaurantProvider(mockApi);
  });

  test('searchRestaurants empty query', () async {
    await provider.searchRestaurants('');

    expect(provider.searchState, isA<Idle>());
  });
}
