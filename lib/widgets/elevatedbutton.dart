import 'package:flutter/material.dart';

class Elevatedbutton extends StatelessWidget {
  final String text;
  final Color? coloring;
  final Color? textColor;
  final VoidCallback? onpressed;
  final double width;
  final Color ? primary;

  const Elevatedbutton({
    required this.text,
    Key? key,
    this.coloring,
    this.textColor,
    this.onpressed,
    this.width = 0,
    this.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: coloring,
        borderRadius: BorderRadius.circular(10),
      ),
      width: width,
      child: ElevatedButton(
        child: Text(
          text, 
          style: TextStyle(color: textColor, fontSize: 18),
          
        ),
        style: ElevatedButton.styleFrom(
          primary: primary,
          side: const BorderSide(color: Colors.black),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: onpressed,
      ),
    );
  }
}
