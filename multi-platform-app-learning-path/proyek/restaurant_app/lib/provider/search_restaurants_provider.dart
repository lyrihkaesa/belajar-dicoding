import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/repository/restaurant_repository.dart';
import 'package:restaurant_app/utils/result_state.dart';

class SearchRestaurantsProvider extends ChangeNotifier {
  final RestaurantRepository restaurantRepository;

  SearchRestaurantsProvider({required this.restaurantRepository});

  RestaurantsResult _restaurantsResult = RestaurantsResult(
    error: false,
    message: "",
    count: 0,
    founded: 0,
    restaurants: [],
  );
  ResultState _state = ResultState.noData;
  String _message = '';
  String _query = '';

  String get message => _message;

  String get query => _query;

  RestaurantsResult get result => _restaurantsResult;

  ResultState get state => _state;

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void searchRestaurant() {
    _fetchSearchRestaurants();
  }

  Future<dynamic> _fetchSearchRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await restaurantRepository.searchRestaurant(_query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        _restaurantsResult = RestaurantsResult(
          error: false,
          message: "",
          count: 0,
          founded: 0,
          restaurants: [],
        );
        notifyListeners();
        return _message = 'Data kosong';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = response;
      }
    } catch (e) {
      _state = ResultState.error;
      _restaurantsResult = RestaurantsResult(
        error: false,
        message: "",
        count: 0,
        founded: 0,
        restaurants: [],
      );
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
