import 'package:flutter/material.dart';

import 'pages/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exemplo BottomNavigationBar e Location",
      home: Main(),
    );
  }
}
