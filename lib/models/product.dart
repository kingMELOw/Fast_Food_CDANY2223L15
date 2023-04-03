import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final List<String>? ingredients;
  final int price;
  final bool vegan;
  int quantity;

  Product({
    required this.name,
    required this.image,
    required this.ingredients,
    required this.price,
    this.vegan = false,
    this.quantity = 1,
  }) : id = const Uuid().v4();
}
