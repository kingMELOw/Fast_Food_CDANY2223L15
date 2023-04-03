import 'package:faker/faker.dart';
import 'dart:math';
// import 'package:uuid/uuid.dart';

import '../models/product.dart';

class ProductsProvider {
  static List<Product> products = generateProducts();

  static List<Product> generateProducts() {
    return [
      for (var i = 1; i <= 30; i++)
        Product(
          name: '${_getRandomAdjective()} ${faker.color.commonColor()}',
          image: 'assets/images/${faker.randomGenerator.integer(20)}.png',
          ingredients: [faker.food.dish(), faker.food.dish()],
          price: faker.randomGenerator.integer(50, min: 10),
          vegan: faker.randomGenerator.boolean(),
        ),
    ];
  }

  static String _getRandomAdjective() {
    List<String> adjectives = [
      'Super',
      'Mega',
      'Royal',
      'Classic',
      'Gourmet',
      'Spicy',
      'Fresh',
      'Juicy',
      'Savory',
      'Crispy',
    ];
    Random random = Random();
    return adjectives[random.nextInt(adjectives.length)];
  }
}
