import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pratikum/model/api/food_api.dart';
import 'package:pratikum/model/food_model.dart';
import 'package:pratikum/repositories.dart';
import 'package:pratikum/screen/foods/foods_view_model.dart';
import 'package:test/test.dart';

import 'food_api_test.mocks.dart';

@GenerateMocks([FoodAPI])
void main() {
  group('Food API', () {
    MockFoodAPI foodAPI = MockFoodAPI();
    test('get all foods returns state', () async {
      var foodsViewModel = FoodsViewModel();
      expect(foodsViewModel.foods.status, ApiStatus.success);

      foodsViewModel.getAllFoods();
      expect(foodsViewModel.foods.status, ApiStatus.loading);

      await foodsViewModel.getAllFoods();

      expect(foodsViewModel.foods.status, ApiStatus.success);
    });
    test('get all foods returns data', () async {
      when(foodAPI.getFoods()).thenAnswer((_) async => <Food>[Food(id: 1, name: 'a')]);
      var foods = await foodAPI.getFoods();
      expect(foods.isNotEmpty, true);
    });
  });
}
