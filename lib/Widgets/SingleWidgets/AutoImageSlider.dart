import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AutoImageSlider extends StatefulWidget {
  final List<dynamic>? imageurls;

  AutoImageSlider({required this.imageurls});

  @override
  State<AutoImageSlider> createState() => _AutoImageSliderState();
}

class _AutoImageSliderState extends State<AutoImageSlider> {
  int activePage = 0;

  List<Widget> generateImageContainers(List<String> imageUrls) {
    return imageUrls.map((imageUrl) {
      return Container(
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.contain,
          ),
        ),
      );
    }).toList();
  }

  // Modified imageIndicator method
  Widget imageIndicator(int imagesLength) {
    List<Widget> indicators = List<Widget>.generate(imagesLength, (index) {
      return Container(
        width: 20,
        height: 5,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:
                      (index == 0) ? Radius.circular(10) : Radius.circular(0),
                  bottomLeft:
                      (index == 0) ? Radius.circular(10) : Radius.circular(0),
                  topRight: (index == imagesLength - 1)
                      ? Radius.circular(10)
                      : Radius.circular(0),
                  bottomRight: (index == imagesLength - 1)
                      ? Radius.circular(10)
                      : Radius.circular(0),
                ),
                color: lightGray50Color,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: (index == 0 || index == activePage)
                      ? Radius.circular(10)
                      : Radius.circular(0),
                  bottomLeft: (index == 0 || index == activePage)
                      ? Radius.circular(10)
                      : Radius.circular(0),
                  topRight: (index == imagesLength - 1 || index == activePage)
                      ? Radius.circular(10)
                      : Radius.circular(0),
                  bottomRight:
                      (index == imagesLength - 1 || index == activePage)
                          ? Radius.circular(10)
                          : Radius.circular(0),
                ),
                color: activePage == index ? lightBlueColor : Colors.transparent,
              ),
            ),
          ],
        ),
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = (widget.imageurls as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];

    return Column(
      children: [
        CarouselSlider(
  items: generateImageContainers(imageUrls),
  options: CarouselOptions(
    height: 250.0,
    enlargeCenterPage: true,
    autoPlay: false,
    aspectRatio: 16 / 9,
    autoPlayCurve: Curves.fastOutSlowIn,
    enableInfiniteScroll: true,
    autoPlayAnimationDuration: Duration(seconds: 1),
    viewportFraction: 1,
    onPageChanged: (index, _) {
      setState(() {
        activePage = index;
      });
    },
  ),
)

// Function to generate Image Containers
,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: imageIndicator(imageUrls.length),
        ),
      ],
    );
  }


}

