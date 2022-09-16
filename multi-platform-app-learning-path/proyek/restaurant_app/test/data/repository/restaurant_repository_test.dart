import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/repository/restaurant_repository.dart';

import 'restaurant_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  RestaurantRepository restaurantRepository = RestaurantRepository();
  group('Restaurant Repository', () {
    test(
        'mengembalikan ResturantResult() jika pemanggilan http berhasil diselesaikan',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"success","count":20,"restaurants":[]}',
              200));
      expect(await restaurantRepository.getRestaurants(client),
          isA<RestaurantsResult>());
    });

    test('melempar Exception jika panggilan http selesai dengan kesalahan', () {
      final client = MockClient();

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error":true,"message":"gagal memuat data","count":0,"restaurants":[]}',
              404));
      expect(restaurantRepository.getRestaurants(client), throwsException);
    });
  });
}
