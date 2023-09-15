import 'package:flutter/material.dart';
import 'package:rest_api_msl/screens/home.dart';

import 'package:rest_api_msl/screens/login.dart';
import 'package:rest_api_msl/utils/themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: theme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
