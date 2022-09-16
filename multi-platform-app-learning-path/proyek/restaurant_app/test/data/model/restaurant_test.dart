import 'package:flutter_test/flutter_test.dart';

import 'package:restaurant_app/data/model/menu.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  group('Restaurant', () {
    test('Restaurant.toJson', () async {
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
      expect(restaurant.toJson(), {
        "id": "id",
        "name": "name",
        "description": "description",
        "pictureId": "pictureId",
        "city": "city",
        "rating": 5.0,
        "address": "address",
      });
    });
    test('Restaurant.fromJson', () async {
      Map<String, dynamic> restaurantJson = {
        "id": "id",
        "name": "name",
        "description": "description",
        "pictureId": "pictureId",
        "city": "city",
        "rating": 5.0,
        "address": "address",
      };

      expect(Restaurant.fromJson(restaurantJson), isA<Restaurant>());
    });
  });
}
