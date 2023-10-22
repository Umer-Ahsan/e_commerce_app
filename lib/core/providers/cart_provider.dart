import 'package:e_commerce_app/core/providers/product_provider.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    final existingItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(
          product: product, quantity: 0), //default CartItem with quantity 0
    );

    if (existingItem.quantity == 0) {
      existingItem.quantity = 1;
      _cartItems.add(existingItem);
    } else {
      existingItem.quantity++;
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    final existingItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(
          product: product, quantity: 0), //default CartItem with quantity 0
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity--;
      if (existingItem.quantity == 0) {
        _cartItems.remove(existingItem);
      }
      notifyListeners();
    }
  }

  void removeItem(Product product) {
    _cartItems.removeWhere((cartItem) => cartItem.product.id == product.id);
    notifyListeners();
  }

  // Add this method to get the CartItem associated with a product
  CartItem getCartItem(Product product) {
    final cartItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    return cartItem;
  }

  bool isProductInCart(Product product) {
    return _cartItems.any((item) => item.product.id == product.id);
  }

  void updateQuantityInCart(Product product, int quantity) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (existingItemIndex >= 0) {
      _cartItems[existingItemIndex].quantity = quantity;
      notifyListeners();
    }
  }

  double get totalPrice {
    return _cartItems.fold(0.0, (total, item) {
      return total + (item.product.price * item.quantity);
    });
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
