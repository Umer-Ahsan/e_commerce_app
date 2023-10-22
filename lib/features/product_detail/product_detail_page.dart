import 'package:e_commerce_app/core/providers/product_provider.dart';
import 'package:e_commerce_app/features/cart/cart_page.dart';
import 'package:e_commerce_app/features/product_detail/product_detail_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: ProductDetailWidget(product: product),
    );
  }
}
