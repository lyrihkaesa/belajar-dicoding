import 'package:restaurant_app/data/model/item.dart';

class MenuModel {
  final List<ItemModel> foods;
  final List<ItemModel> drinks;

  MenuModel({
    required this.foods,
    required this.drinks,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        foods: json['foods'] == null
            ? []
            : List<ItemModel>.from(
                json['foods'].map((x) => ItemModel.fromJson(x))),
        drinks: json['foods'] == null
            ? []
            : List<ItemModel>.from(
                json['drinks'].map((x) => ItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": foods,
        "drinks": drinks,
      };
}
