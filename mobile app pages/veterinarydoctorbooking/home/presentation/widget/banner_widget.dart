import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int showedIndex = 0;

  final banners = [
    "assets/img/doc.jpg",
    "assets/img/6677.jpg",
    "assets/img/aa.jpg",
    "assets/img/7620.jpg",
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
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  showedIndex = index;
                });
              },
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
          Positioned(
            left: 16,
            bottom: 16,
            child: Row(
              children: List.generate(
                banners.length,
                (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: showedIndex == index ? 24 : 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: showedIndex == index
                          ? Color.fromRGBO(159, 201, 243, 1.000)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
