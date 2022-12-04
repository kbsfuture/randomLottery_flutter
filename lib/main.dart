import 'package:flutter/material.dart';
import 'package:startup/screen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: homescreen(),
    ),
  );
}
