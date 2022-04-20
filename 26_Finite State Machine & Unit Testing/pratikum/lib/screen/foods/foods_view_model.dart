import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pratikum/model/api/food_api.dart';
import 'package:pratikum/model/food_model.dart';
import 'package:pratikum/repositories.dart';

class FoodsViewModel with ChangeNotifier {
  ApiResponse<List<Food>> _foods = ApiResponse(status: ApiStatus.success, data: []);

  ApiResponse<List<Food>> get foods => _foods;

  void changeState(ApiResponse<List<Food>> state) {
    _foods = state;
    notifyListeners();
  }

  getAllFoods() async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final __foods = await FoodAPI.getFoods();
      changeState(ApiResponse(status: ApiStatus.success, data: __foods));
    } catch (e) {
      if (e is DioError) {
        changeState(ApiResponse(status: ApiStatus.error, message: e.message));
        return;
      }
      changeState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
    }
  }
}
