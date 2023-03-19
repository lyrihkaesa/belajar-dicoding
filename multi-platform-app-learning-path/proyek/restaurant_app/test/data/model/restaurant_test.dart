import 'package:flutter_test/flutter_test.dart';

import 'package:restaurant_app/data/model/menu.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  group('Restaurant', () {
    // arrange
    final restorantJson = {
      "id": "id",
      "name": "name",
      "description": "description",
      "pictureId": "pictureId",
      "city": "city",
      "rating": 5.0,
      "address": "address",
    };

    final restaurant = Restaurant(
      id: 'id',
      name: 'name',
      description: 'description',
      pictureId: 'pictureId',
      city: 'city',
      rating: 5,
      address: 'address',
      categories: [],
      menus: MenuModel(drinks: [], foods: []),
      customerReviews: [],
    );

    test('Restaurant.toJson', () async {
      // assert
      expect(restaurant.toJson(), restorantJson);
    });
    test('Restaurant.fromJson', () async {
      // assert
      expect(Restaurant.fromJson(restorantJson), isA<Restaurant>());
    });
  });
}
