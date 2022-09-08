import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/restaurant.dart';

class RestaurantRepository {
  Future<List<RestaurantModel>> getDataRestaurant(String search) async {
    final response =
        await rootBundle.loadString('assets/local-restaurants.json');
    final restaurantsJson = await json.decode(response);
    List<RestaurantModel> restaurants =
        parseRestaurant(restaurantsJson["restaurants"]);
    restaurants = restaurants
        .where((element) =>
            element.name.toLowerCase().contains(search.toLowerCase()) ||
            element.city.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return restaurants;
  }
}
