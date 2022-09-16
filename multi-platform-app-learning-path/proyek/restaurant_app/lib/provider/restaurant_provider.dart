import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/repository/restaurant_repository.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantsProvider extends ChangeNotifier {
  final RestaurantRepository restaurantRepository;

  RestaurantsProvider({required this.restaurantRepository}) {
    _fetchAllRestaurant();
  }

  late RestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantsResult get result => _restaurantsResult;

  ResultState get state => _state;

  void getAllRestaurant() {
    _fetchAllRestaurant();
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await restaurantRepository.getRestaurants(Client());
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data kosong';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
