import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int count;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
  });
}

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];
  final bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<List<Product>> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data
            .map((item) => Product(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'].toDouble(),
                  description: item['description'],
                  category: item['category'],
                  image: item['image'],
                  rate: item['rating']['rate'].toDouble(),
                  count: item['rating']['count'],
                ))
            .toList();
        return products; // Return the list of products
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Error fetching products: $error');
    }
  }

  // Add other methods for updating and managing products

  Product getProductById(int productId) {
    return _products.firstWhere((product) => product.id == productId);
  }
}
