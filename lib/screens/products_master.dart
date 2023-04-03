import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import '../models/product.dart';
import './cart.dart';

class ProductsMaster extends StatefulWidget {
  const ProductsMaster({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductsMasterState createState() => _ProductsMasterState();
}

class _ProductsMasterState extends State<ProductsMaster> {
  final List<Product> _products = ProductsProvider.products;
  bool _veganOnly = false;
  final List<Product> _selectedProducts =
      []; // la liste de produits sélectionnés (important)

  void _addToCart(Product product) {
    setState(() {
      _selectedProducts.add(product);
    });
    final snackBar = SnackBar(
      content: Text('${product.name} a été ajouté au panier.'),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = _veganOnly
        ? _products.where((product) => product.vegan).toList()
        : _products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Food DELAMAMA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              setState(() {
                _veganOnly = !_veganOnly;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(cartProducts: _selectedProducts),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          Product product = filteredProducts[index];
          return ListTile(
            leading: Image.asset(
              product.image,
              width: 60,
              height: 60,
            ),
            title: Text(
              product.name,
              style: TextStyle(
                color: product.vegan ? Colors.lightGreen : Colors.white,
              ),
            ),
            subtitle: Text(product.ingredients!.join(', ')),
            trailing: Text('${product.price}€'),
            onTap: () {
              _addToCart(product);
            },
          );
        },
      ),
    );
  }
}
