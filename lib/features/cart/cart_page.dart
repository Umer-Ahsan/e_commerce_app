// import 'package:e_commerce_app/core/providers/cart_provider.dart';
// import 'package:e_commerce_app/core/providers/product_provider.dart';
// import 'package:e_commerce_app/features/cart/cart_item_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = context.read<CartProvider>();
//     final productsInCart = cartProvider.cartItems;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: productsInCart.length,
//               itemBuilder: (context, index) {
//                 final product = productsInCart[index];

//                 return CartItemTile(product: product);
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   'Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     color: Colors.deepPurple,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     //Can Add checkout logic here
//                   },
//                   child: const Text('Checkout'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
