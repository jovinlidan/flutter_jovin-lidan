import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/api/carousel_api.dart';
import 'package:mini_project/model/carousel_model.dart';
import 'package:mini_project/services/services.dart';

class CarouselViewModel with ChangeNotifier {
  ApiResponse<List<Carousel>>? _carousel = ApiResponse(status: ApiStatus.success);
  ApiResponse<List<Carousel>>? get carousel => _carousel;

  void changeState(ApiResponse<List<Carousel>>? state) {
    _carousel = state;
    notifyListeners();
  }

  Future<ApiResponse<List<Carousel>>> getCarousel() async {
    try {
      changeState(ApiResponse(status: ApiStatus.loading));
      final res = await CarouselAPI.getCarousel();
      changeState(ApiResponse<List<Carousel>>(data: res, status: ApiStatus.success));
    } catch (e) {
      if (e is DioError) {
        changeState(
          ApiResponse(
              status: ApiStatus.error,
              message:
                  (e.response?.data ?? {'message': e.message} as dynamic)['message'] as dynamic),
        );
      } else {
        changeState(ApiResponse(status: ApiStatus.error, message: "Error!!!"));
      }
    }
    return Future.value(_carousel);
  }
}
