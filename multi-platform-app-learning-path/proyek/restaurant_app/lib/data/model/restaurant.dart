import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/item.dart';
import 'package:restaurant_app/data/model/menu.dart';

class RestaurantsResult {
  final bool error;
  final String message;
  final int count;
  final int founded;
  final List<Restaurant> restaurants;

  RestaurantsResult({
    required this.error,
    required this.message,
    required this.count,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"] ?? "",
        count: json["count"] ?? 0,
        founded: json["founded"] ?? 0,
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final String address;
  final MenuModel menus;
  final List<ItemModel> categories;
  List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.address,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        address: json["address"] ?? "",
        categories: json['categories'] == null
            ? []
            : List<ItemModel>.from(
                json['categories'].map((x) => ItemModel.fromJson(x))),
        menus: json['menus'] == null
            ? MenuModel(drinks: [], foods: [])
            : MenuModel.fromJson(json['menus']),
        customerReviews: json['customerReviews'] == null
            ? []
            : List<CustomerReview>.from(json['customerReviews']
                .map((x) => CustomerReview.fromJson(x))).reversed.toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "address": address,
      };
}
