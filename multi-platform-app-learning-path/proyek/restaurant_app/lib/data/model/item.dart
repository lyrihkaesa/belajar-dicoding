class ItemModel {
  final String name;

  ItemModel({
    required this.name,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        name: json['name'],
      );
}
