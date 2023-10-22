import 'package:e_commerce_app/core/providers/product_provider.dart';
import 'package:e_commerce_app/features/cart/cart_page.dart';
import 'package:e_commerce_app/features/product_detail/product_detail_page.dart';
import 'package:e_commerce_app/features/product_listing/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListingPageState createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  Future<List<Product>>? productData; //initializing the productData

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_conditional_assignment
    if (productData == null) {
      // Fetching data if productData is null
      productData = context.read<ProductProvider>().fetchProducts();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: FutureBuilder<List<Product>>(
        future: productData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          } else {
            // Data has been successfully fetched & displaying the products
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: ProductCard(product: product));
              },
            );
          }
        },
      ),
    );
  }
}
