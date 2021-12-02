import 'package:event_spotter/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MaterialApp(
      home: Singup(),
      debugShowCheckedModeBanner: false,
    ));
  });
}
