class DrinkModel {
  final String name;

  DrinkModel({
    required this.name,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) => DrinkModel(
        name: json['name'],
      );
}

List<DrinkModel> parseDrink(List<dynamic>? drinkList) {
  if (drinkList == null) {
    return [];
  }

  return drinkList.map((json) => DrinkModel.fromJson(json)).toList();
}
