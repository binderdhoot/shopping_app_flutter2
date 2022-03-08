import 'package:flutter/cupertino.dart';

class CartItems {
  final String id;
  final String title;
  final int qty;
  final double price;
  final String imageUrl;
  CartItems({
    required this.id,
    required this.title,
    required this.qty,
    required this.price,
    required this.imageUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItems> _items = {};

  Map<String, CartItems> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.00;
    _items.forEach((key, value) {
      total += (value.price * value.qty);
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
    String imageUrl,
    int qty,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingvalue) => CartItems(
          id: existingvalue.id,
          title: existingvalue.title,
          qty: existingvalue.qty + 1,
          price: existingvalue.price,
          imageUrl: existingvalue.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItems(
          id: DateTime.now().toString(),
          title: title,
          qty: qty,
          price: price,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.qty > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItems(
            id: existingCartItem.id,
            title: existingCartItem.title,
            qty: existingCartItem.qty - 1,
            price: existingCartItem.price,
            imageUrl: existingCartItem.imageUrl),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
