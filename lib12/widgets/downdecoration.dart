import 'package:flutter/material.dart';

class Downdecoration extends StatelessWidget {
  const Downdecoration({
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
    // color: Colors.brown
     )
     ,
     child: Stack(
       children: [
         Positioned(
             bottom: size.height * 0.02,
             right: size.width * 0.15,
             child: const Image(
                 image:
                     AssetImage('Assets/images/circle.png'))),
         Positioned(
           bottom: size.height * 0.01,
           right: size.width * 0.22,
           child: const Image(
               image: AssetImage('Assets/images/cross.png')),
           height: 30,
         ),
          Positioned(
           bottom: size.height*0.01,
           right: size.width*0.02,
           child: const Image(
               image: AssetImage('Assets/images/lines.png')),
         ),
          Positioned(
           bottom: size.height*0.025,
           right: size.width*0.02,
           child: const Image(
               image: AssetImage('Assets/images/lines.png')),
         ),
           Positioned(
           bottom: size.height*0.04,
           right: size.width*0.02,
           child: const Image(
               image: AssetImage('Assets/images/lines.png')),
         ),
         const Positioned(
             bottom: 0,
             left: 0,
             child: Image(
                 image:
                     AssetImage('Assets/images/down0.png'))),
         const Positioned(
             bottom: 0,
             left: 0,
             child: Image(
                 image:
                     AssetImage('Assets/images/down1.png'))),
         const Positioned(
             bottom: 0,
             left: 0,
             child: Image(
                 image:
                     AssetImage('Assets/images/down2.png'))),
         const Positioned(
             bottom: 0,
             left: 0,
             child: Image(
                 image:
                     AssetImage('Assets/images/down3.png'))),
         const Positioned(
             bottom: 0,
             left: 0,
             child: Image(
                 image: AssetImage('Assets/images/down4.png')))
       ],
     ),
                    );
  }
}

