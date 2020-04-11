import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imageList = [
  'assets/1.jpg',
  'assets/2.jpg',
  'assets/3.jpg',
  'assets/4.jpg',
  'assets/5.jpg',
  'assets/6.jpg'
];

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          CarouselSlider(
            height: 600.0,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
            autoPlay: true,
            enlargeCenterPage: true,
            items: [
              'assets/1.jpg',
              'assets/2.png',
              'assets/3.png',
              'assets/4.png',
              'assets/5.png',
              'assets/6.jpg'
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                          color: Colors.black
                      ),
                      //child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                        child: Image(
                            image: new AssetImage(i),
                            fit: BoxFit.contain
                        )
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}