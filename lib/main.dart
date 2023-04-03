import 'package:flutter/material.dart';
import 'package:fastfood/screens/products_master.dart';
// import 'screens/cart.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Food',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home: ProductsMaster(),
    );
  }
}

void main() => runApp(const MyApp(
      title: 'Fast Food',
    ));
