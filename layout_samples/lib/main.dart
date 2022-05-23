import 'package:flutter/material.dart';
//使用するdartをimportする
import 'grid_view_page.dart';

//MyAppを動かす
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridViewPage(),
    );
  }
}
