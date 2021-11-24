import 'package:flutter/material.dart';

class Smallbutton extends StatelessWidget {
  const Smallbutton({
    Key? key,
     this.size, this.icon, this.onpressed, 
  }) : super(key: key);

  final double  ? size;
  final IconData ? icon;
  final VoidCallback ? onpressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: size,
            decoration: BoxDecoration(
                color: const Color(0XFFECF2F3),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: onpressed,
              icon:  Icon(icon),
              color: const Color(0XFF38888F),
            )),
      ],
    );
  }
}
