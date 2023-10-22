import 'package:e_commerce_app/core/providers/cart_provider.dart';
import 'package:e_commerce_app/core/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailWidget extends StatelessWidget {
  final Product product;

  const ProductDetailWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final isInCart = cartProvider.isProductInCart(product);
        final cartItem = cartProvider.getCartItem(product);

        void addToCart() {
          cartProvider.addToCart(product);
        }

        void removeItem() {
          cartProvider.removeItem(product);
        }

        List<Widget> buildButtons() {
          if (isInCart) {
            // Display quantity picker and "Remove from Cart" button if the product is in the cart
            return [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Decrease quantity
                      if (cartItem.quantity > 1) {
                        cartProvider.updateQuantityInCart(
                          cartItem.product,
                          cartItem.quantity - 1,
                        );
                      } else {
                        // Remove the entire product from the cart
                        cartProvider.removeFromCart(cartItem.product);
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(cartItem.quantity.toString()), // Display quantity
                  IconButton(
                    onPressed: () {
                      // Increase quantity
                      cartProvider.updateQuantityInCart(
                        cartItem.product,
                        cartItem.quantity + 1,
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                  ElevatedButton(
                    onPressed: () => removeItem(),
                    child: const Text('Remove from Cart'),
                  ),
                ],
              ),
            ];
          } else {
            // Display "Add to Cart" button if the product is not in the cart
            return [
              ElevatedButton(
                onPressed: () => addToCart(),
                child: const Text('Add to Cart'),
              ),
            ];
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                product.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                'Category: ${product.category}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ...buildButtons(), //buttons based on the isInCart condition
          ],
        );
      },
    );
  }
}
