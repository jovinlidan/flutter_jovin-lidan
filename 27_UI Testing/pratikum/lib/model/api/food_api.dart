import 'package:pratikum/model/food_model.dart';
import 'package:pratikum/repositories.dart';

class FoodAPI {
  static Future<List<Food>> getFoods() async {
    Repositories repo = Repositories();
    // final response = await repo.get(url: 'foods');
    // return await Future.value(Food.decode(response));
    final response = [Food(id: 1, name: "Nasi Goreng"), Food(id: 2, name: "Ayam")];
    return await Future.value(response);
  }
}
