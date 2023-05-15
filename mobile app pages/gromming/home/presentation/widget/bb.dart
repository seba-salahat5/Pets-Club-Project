import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannergWidget extends StatefulWidget {
  const BannergWidget({super.key});

  @override
  State<BannergWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannergWidget> {
  int showedIndex = 0;

  final banners = [
    "assets/img/bbbb.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: banners.length,
            options: CarouselOptions(
              initialPage: showedIndex,
              viewportFraction: 1,
              autoPlay: false,
              // s
            ),
            itemBuilder: (context, index, _) {
              return Image(
                image: AssetImage(
                  banners[index],
                ),
                fit: BoxFit.fill,
              );
            },
          ),
        
        ],
      ),
    );
  }
}
