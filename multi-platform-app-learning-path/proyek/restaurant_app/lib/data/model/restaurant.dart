import 'package:restaurant_app/data/model/menu.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final MenuModel menus;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'],
        menus: MenuModel.fromJson(json['menus']),
      );
}

List<RestaurantModel> parseRestaurant(List<dynamic>? restaurantList) {
  if (restaurantList == null) {
    return [];
  }

  return restaurantList.map((json) => RestaurantModel.fromJson(json)).toList();
}
