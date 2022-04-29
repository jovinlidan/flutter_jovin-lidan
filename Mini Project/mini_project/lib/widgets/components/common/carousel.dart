import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/model/carousel_model.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CarouselWidget extends StatefulWidget {
  final List<Carousel>? data;
  bool isLoading;
  CarouselWidget({Key? key, required this.data, required this.isLoading}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading || widget.data == null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: SkeletonAnimation(
          shimmerColor: Colors.blue[900]!,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
    }
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 1,
      ),
      items: widget.data?.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    i.image!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return const Center(child: CircularProgressIndicator());
                      // You can use LinearProgressIndicator, CircularProgressIndicator, or a GIF instead
                    },
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
