import 'package:e_commerce_app/core/providers/cart_provider.dart';
import 'package:e_commerce_app/features/cart/cart_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            final productsInCart = cartProvider.cartItems;
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: productsInCart.length,
                    itemBuilder: (context, index) {
                      final cartItem = productsInCart[index];
                      return CartItemTile(cartItem: cartItem);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add checkout logic here
                        },
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
