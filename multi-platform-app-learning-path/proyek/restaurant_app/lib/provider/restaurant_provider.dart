import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/repository/restaurant_repository.dart';

enum ResultState { loading, noData, hasData, error }

enum ReviewState { loading, noData, hasData, error }

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
      final response = await restaurantRepository.getRestaurants();
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

class DetailRestaurantProvider extends ChangeNotifier {
  final RestaurantRepository restaurantRepository;

  DetailRestaurantProvider({required this.restaurantRepository});

  late Restaurant _restaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Restaurant get result => _restaurant;

  ResultState get state => _state;

  void setRestaurant(Restaurant restaurant) {
    _restaurant = restaurant;
    notifyListeners();
    _fetchRestaurantById(restaurant.id);
  }

  Future<dynamic> _fetchRestaurantById(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await restaurantRepository.getRestaurantById(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurant = restaurant;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  CustomerReviewResponse _customerReviewResponse = CustomerReviewResponse(
    error: false,
    message: '',
    customerReviews: [],
  );

  ReviewState _stateReview = ReviewState.noData;

  ReviewState get stateReview => _stateReview;

  String _name = '';
  String _review = '';
  String _messageReview = '';

  String get name => _name;
  String get review => _review;

  String get messageReview => _messageReview;

  CustomerReviewResponse get resultReview => _customerReviewResponse;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setReview(String review) {
    _review = review;
    notifyListeners();
  }

  void sendReview() {
    _addReviewRestaurant();
    _messageReview = '"$_name : $_review"';
    _name = '';
    _review = '';
  }

  Future<dynamic> _addReviewRestaurant() async {
    try {
      _stateReview = ReviewState.loading;
      notifyListeners();
      final response = await restaurantRepository.addReview(
          id: _restaurant.id, name: _name, review: _review);
      if (response.customerReviews.isEmpty) {
        _stateReview = ReviewState.noData;
        _customerReviewResponse = CustomerReviewResponse(
          error: false,
          message: '',
          customerReviews: _restaurant.customerReviews,
        );
        notifyListeners();
        return _message = 'Data kosong';
      } else {
        _stateReview = ReviewState.hasData;
        _restaurant.customerReviews = response.customerReviews;
        notifyListeners();
        return _customerReviewResponse = response;
      }
    } catch (e) {
      _stateReview = ReviewState.error;
      notifyListeners();
      Future.delayed(
        const Duration(seconds: 3),
        () {
          _stateReview = ReviewState.noData;
          notifyListeners();
        },
      );
      return _message = 'Error --> $e';
    }
  }
}

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
