import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  int _currentIndex = 0;
  List imgList = [
    'images/content1.PNG',
    'images/content2.png',
    'images/content3.png',
    'images/content4.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('carousel demo'),
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                _buildItemContainer('images/content1.PNG'),
                _buildItemContainer('images/content2.png'),
                _buildItemContainer('images/content3.png'),
              ],
              options: CarouselOptions(
                height: 200,
                viewportFraction: 0.8,
                aspectRatio: 16 / 9,
                initialPage: 0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: false,
                enableInfiniteScroll: true,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemContainer(imageSrc) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imageSrc),
          fit: BoxFit.cover,
        ),
      ),
    );
    // imagesSrc.map((image) => {
    //       result = Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           image: DecorationImage(
    //             image: AssetImage(image),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       )
    //     });
    // return result;

    // for (int i = 0; i < imageSrc.length; i++) {

    // }
  }
}
