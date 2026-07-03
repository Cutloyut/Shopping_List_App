class ShoppingItemModel {
  int id;
  String name;
  String unit;
  String category;
  double estimatedPrice;
  double count;
  bool state;
  DateTime dateadd;
  ShoppingItemModel({
    required this.id,
    required this.name,
    required this.count,
    required this.state,
    required this.dateadd,
    required this.category,
    required this.estimatedPrice,
    required this.unit,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "count": count,
      "category": category,
      "estimatedPrice": estimatedPrice,
      "unit": unit,
      "state": state,
      "dateadd": dateadd.toIso8601String(),
    };
  }

  factory ShoppingItemModel.fromJson(Map<String, dynamic> json) {
    return ShoppingItemModel(
      id: json['id'],
      name: json['name'],
      count: json['count'],
      unit: json['unit'],
      category: json['category'],
      state: json['state'],
      estimatedPrice: json['estimatedPrice'],
      dateadd: DateTime.parse(json['dateadd']),
    );
  }
}
