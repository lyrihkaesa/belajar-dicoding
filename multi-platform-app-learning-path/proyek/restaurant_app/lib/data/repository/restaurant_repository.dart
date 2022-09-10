import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantRepository {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  // Get List of Restaurant
  Future<RestaurantsResult> getRestaurants() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat daftar restoran');
    }
  }

  // Get Detail of Restaurant by id
  Future<Restaurant> getRestaurantById(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return Restaurant.fromJson(body["restaurant"]);
    } else {
      throw Exception('Gagal memuat detail restaurant dengan ID: "$id"');
    }
  }

  // Search Restaurant by name, category, and menu
  Future<RestaurantsResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mencari restoran dengan pencarian: "$query"');
    }
  }

  // Add Restaurant Review
  Future<CustomerReviewResponse> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        <String, String>{
          'id': id,
          'name': name,
          'review': review,
        },
      ),
    );
    if (response.statusCode == 201) {
      return CustomerReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('$name Gagal menambahkan review "$review"');
    }
  }
}
