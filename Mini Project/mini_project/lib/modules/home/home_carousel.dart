import 'package:flutter/material.dart';
import 'package:mini_project/services/services.dart';
import 'package:mini_project/view_models/carousel_view_model.dart';
import 'package:mini_project/widgets/components/common/carousel.dart';
import 'package:provider/provider.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key}) : super(key: key);

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CarouselViewModel>(context, listen: false).getCarousel();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarouselViewModel>(
      builder: (_, state, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommendations",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 16),
          CarouselWidget(
            isLoading: state.carousel?.status == ApiStatus.loading,
            data: state.carousel?.data,
          ),
        ],
      ),
    );
  }
}
