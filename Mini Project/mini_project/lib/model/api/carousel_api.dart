import 'package:mini_project/model/carousel_model.dart';
import 'package:mini_project/services/services.dart';

class CarouselAPI {
  static Future<List<Carousel>> getCarousel() async {
    Services repo = Services();
    final response = await repo.get(url: 'Carousel');
    return await Future.value(response.map<Carousel>((e) => Carousel.fromJson(e)).toList());
  }
}
