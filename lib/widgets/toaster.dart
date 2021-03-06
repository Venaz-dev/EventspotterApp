import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToaster(String title) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.blueAccent,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
showToaster1(String title) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP_RIGHT,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.blueAccent,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}