import 'package:e_commerce_app/core/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatefulWidget {
  final CartItem cartItem;

  const CartItemTile({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Column(
      children: [
        ListTile(
          title: Text(widget.cartItem.product.title),
          subtitle: Text(
              '\$${(widget.cartItem.product.price * widget.cartItem.quantity).toStringAsFixed(2)}'), // Display total price
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  // Decrease quantity
                  if (widget.cartItem.quantity > 1) {
                    cartProvider.updateQuantityInCart(
                      widget.cartItem.product,
                      widget.cartItem.quantity - 1,
                    );
                  } else {
                    // Remove the entire product from the cart
                    cartProvider.removeFromCart(widget.cartItem.product);
                  }
                },
                icon: const Icon(Icons.remove),
              ),
              Text(widget.cartItem.quantity.toString()), // Display quantity
              IconButton(
                onPressed: () {
                  // Increase quantity
                  cartProvider.updateQuantityInCart(
                    widget.cartItem.product,
                    widget.cartItem.quantity + 1,
                  );
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  // Remove the entire product from the cart
                  cartProvider.removeItem(widget.cartItem.product);
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}
