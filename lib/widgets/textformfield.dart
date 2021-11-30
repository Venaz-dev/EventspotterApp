import 'package:flutter/material.dart';

class Textform extends StatefulWidget {
  const Textform({
    this.controller,
    Key? key,
    this.label,
    this.isSecure = true,
    this.keyboard,
    this.validator,
    this.icon,
    this.suffix,
    this.input = true,
    this.color,
    this.onPressed,
    this.width = 0.0,
    this.maxlines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final bool isSecure;
  final TextInputType? keyboard;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final bool input;
  final IconData? suffix;
  final Color? color;
  final VoidCallback? onPressed;
  final double width;
  final int maxlines;
  @override
  State<Textform> createState() => _TextformState();
}

class _TextformState extends State<Textform> {
  //bool _isSecure = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      enabled: widget.input,
      maxLines: widget.maxlines,
      obscureText: widget.isSecure,
      cursorColor: Colors.black,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: widget.width),
        prefixIcon: Icon(
          widget.icon,
          color: const Color(0XFF277279),
        ),
        suffixIcon: IconButton(
          icon: Icon(widget.suffix),
          onPressed: widget.onPressed,
        ),
        filled: true,
        fillColor: widget.color, //0XFFEBF2F2
        hintText: widget.label,
        hintStyle: const TextStyle(color: Color(0XFF74ABB0)),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: widget.keyboard,
      validator: widget.validator,
    );
  }
}
