import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gram_villa_latest/dao/product_dao.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:gram_villa_latest/service/auth_service.dart';
import 'package:provider/provider.dart';

class CartDao extends ChangeNotifier {
  Map<String, int> _items = {};
  FirebaseFirestore? _instance = FirebaseFirestore.instance;
  Map<String, ProductItem> _productItems = {};

  UnmodifiableMapView<String, int> get items => UnmodifiableMapView(_items);

  UnmodifiableMapView<String, ProductItem> get productItems =>
      UnmodifiableMapView(_productItems);

  double getCartTotal() {
    double totalAmount = 0;
    _productItems.values.forEach((element) {
      totalAmount += element.default_unit_price * element.cart_quantity;
    });
    return totalAmount;
  }

  Future<void> addItem(BuildContext context, ProductItem productItem) async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    ProductDao productService = Provider.of<ProductDao>(context, listen: false);
    Map<String, ProductItem> items = productService.getProductsCache();
    items.values.forEach((element) {
      print(element.displayName + "  -  " + element.cart_quantity.toString());
    });
    if (_items.containsKey(productItem.id)) {
      _items[productItem.id] = _items[productItem.id]! + 1;
    } else {
      _items[productItem.id] = 1;
    }
    await _instance!.collection('carts').doc(authService.uid).set(
      {'cartItems': _items},
    ).then((value) {
      productItem.cart_quantity = _items[productItem.id]!;
      _productItems[productItem.id] = productItem;
      notifyListeners();
    });
  }

  Future<void> removeItem(BuildContext context, ProductItem productItem) async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    // ProductDao productService = Provider.of<ProductDao>(context, listen: false);
    // Map<String, ProductItem> items = productService.getProductsCache();
    // print(items.values);
    if (_items.containsKey(productItem.id)) {
      _items[productItem.id] = _items[productItem.id]! - 1;
    }
    if (_items[productItem.id] == 0) {
      _items.remove(productItem.id);
      _productItems.remove(productItem.id);
    }
    await _instance!.collection('carts').doc(authService.uid).set(
      {'cartItems': _items},
    ).then((value) {
      productItem.cart_quantity =
          _items.containsKey(productItem.id) ? _items[productItem.id]! : 0;
      notifyListeners();
    });
  }

  Future<void> loadCartItemsFromFirebase(BuildContext context) async {
    // clear the items up front
    if (_items.length > 0) {
      _items.clear();
    }

    AuthService authService = Provider.of<AuthService>(context, listen: false);
    ProductDao productService = Provider.of<ProductDao>(context, listen: false);

    if (await authService.isLoggedIn()) {
      await _instance!
          .collection('carts')
          .doc(authService.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> cartItems =
              snapshot.get(FieldPath(['cartItems']));
          cartItems.forEach((key, quant) {
            ProductItem? item = productService.getProductByIdFromCache(key);
            if (item != null && item.enabled) {
              item.cart_quantity = quant;
              _items[key] = quant;
              _productItems[key] = item;
            }
          });
          notifyListeners();
        } else {
          // Adding dummy cart for initialisation
          _instance!
              .collection('carts')
              .doc(authService.uid)
              .set({'cartItems': {}});
          notifyListeners();
        }
      });
    }
  }

  Future<void> clearCart(BuildContext context) async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    _items.clear();
    _productItems.values.forEach((element) {
      element.cart_quantity = 0;
    });
    _productItems.clear();
    _instance!.collection('carts').doc(authService.uid).set({'cartItems': {}});
    notifyListeners();
  }

}
