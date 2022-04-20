import 'dart:convert';

class Food {
  int id;
  String name;

  Food({required this.id, required this.name});

  factory Food.fromJson(Map<String, dynamic> jsonData) {
    return Food(id: jsonData['id'], name: jsonData['name']);
  }

  static Map<String, dynamic> toMap(Food food) => {'id': food.id, 'name': food.name};

  static String encode(List<Food> foods) => json.encode(
        foods.map<Map<String, dynamic>>((food) => Food.toMap(food)).toList(),
      );
  static Map<String, dynamic> encodeOne(Food food) => Food.toMap(food);

  static List<Food> decode(List<dynamic> data) =>
      (data.map<Food>((item) => Food.fromJson(item)).toList());

  static Food decodeOne(dynamic food) => Food.fromJson(food);
}
