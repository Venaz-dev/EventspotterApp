import 'package:flutter/material.dart';

class Smallbutton extends StatelessWidget {
  const Smallbutton({
    Key? key,
    this.height,
    this.icon,
    this.onpressed,
  }) : super(key: key);

  final double? height;
  final IconData? icon;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
              color: const Color(0XFFECF2F3),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            onPressed: onpressed,
            icon: Icon(
              icon,
              size: size.height * 0.023,
            ),
            color: const Color(0XFF38888F),
          ),
        )
      ],
    );
  }
}
