import 'package:flutter/material.dart';

class Updecoration extends StatelessWidget {
  const Updecoration({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.07,
      width: size.width,
      decoration: const BoxDecoration(
          //  color: Colors.brown
          ),
      child: Stack(
        children: [
          Positioned(
              top: size.height * 0.011,
              left: size.width * 0.07,
              child: const Image(
                  image: AssetImage('Assets/images/circle.png'))),
          Positioned(
            top: size.height * 0.04,
            left: size.width * 0.13,
            child: const Image(
                image: AssetImage('Assets/images/cross.png')),
            height: 30,
          ),
          const Positioned(
              right: 0,
              child:
                  Image(image: AssetImage('Assets/images/up1.png'))),
          const Positioned(
              right: 0,
              child:
                  Image(image: AssetImage('Assets/images/up2.png'))),
          const Positioned(
              right: 0,
              child:
                  Image(image: AssetImage('Assets/images/up3.png'))),
          const Positioned(
              right: 0,
              child:
                  Image(image: AssetImage('Assets/images/up4.png'))),
                    const Positioned(
              right: 0,
              child:
                  Image(image: AssetImage('Assets/images/up5.png')))
        ],
      ),
    );
  }
}
