import 'package:flutter/material.dart';
import '../models/product.dart';

class Cart extends StatefulWidget {
  final List<Product> cartProducts;

  const Cart({Key? key, required this.cartProducts}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  void _removeFromCart(Product product) {
    setState(() {
      widget.cartProducts.remove(product);
    });
    final snackBar = SnackBar(
      content: Text('${product.name} a été supprimé du panier.'),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    calculateTotal(widget.cartProducts); // Met à jour le prix total
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier (${widget.cartProducts.length})'),
      ),
      body: widget.cartProducts.isEmpty
          ? const Center(
              child: Text('Le panier est vide.'),
            )
          : ListView.builder(
              itemCount: widget.cartProducts.length,
              itemBuilder: (context, index) {
                Product product = widget.cartProducts[index];
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
                  subtitle: Text('${product.price}€'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (product.quantity > 1) {
                              product.quantity--;
                              final snackBar = SnackBar(
                                content: Text(
                                  '1 ${product.name} a été supprimé.',
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.orange,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        },
                      ),
                      Text('${product.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            product.quantity++;
                            final snackBar = SnackBar(
                              content: Text(
                                '1 ${product.name} a été ajouté.',
                              ),
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.lightGreenAccent,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _removeFromCart(product);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '${calculateTotal(widget.cartProducts)}€',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotal(List<Product> cartProducts) {
    double total = 0;
    for (var product in cartProducts) {
      total += product.price * product.quantity;
    }
    return total;
  }
}
