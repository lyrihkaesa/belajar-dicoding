import 'package:restaurant_app/data/model/drink.dart';
import 'package:restaurant_app/data/model/food.dart';

class MenuModel {
  final List<FoodModel> foods;
  final List<DrinkModel> drinks;

  MenuModel({
    required this.foods,
    required this.drinks,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        foods: parseFood(json['foods']),
        drinks: parseDrink(json['drinks']),
      );
}
