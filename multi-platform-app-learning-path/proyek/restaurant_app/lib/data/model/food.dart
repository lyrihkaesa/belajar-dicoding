class FoodModel {
  final String name;

  FoodModel({
    required this.name,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        name: json['name'],
      );
}

List<FoodModel> parseFood(List<dynamic>? foodList) {
  if (foodList == null) {
    return [];
  }

  return foodList.map((json) => FoodModel.fromJson(json)).toList();
}
