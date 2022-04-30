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
  final CarouselController _controller = CarouselController();
  int _current = 0;

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
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              onPageChanged: (index, __) {
                setState(() {
                  _current = index;
                });
              }),
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
        ),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.data!.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _current == entry.key ? 12.0 : 8.0,
                  height: _current == entry.key ? 12.0 : 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, style: BorderStyle.solid, width: 1),
                      shape: BoxShape.circle,
                      color: (_current == entry.key ? Colors.blue[900]! : Colors.white)
                          .withOpacity(_current == entry.key ? 1 : 1)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
