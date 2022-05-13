import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gram_villa_latest/models/product_item.dart';

class ProductDao {
  Map<String, ProductItem> _productItems = {};

  Map<String, ProductItem> getProductsCache()  {
    return _productItems;
  }

  final productRef = FirebaseFirestore.instance
      .collection('products')
      .withConverter<ProductItem>(
        fromFirestore: (snapshots, _) =>
            ProductItem.fromJson(snapshots.data()!),
        toFirestore: (productItem, _) => productItem.toJson(),
      );

  Future<List<ProductItem>> getProducts() async {
    return (await productRef.get()).docs.map((e) => e.data()).toList();
  }

  Future<void> loadProductItemsFromFirebase() async {
    // clear the items up front
    if (_productItems.length > 0) {
      _productItems.clear();
    }
    await productRef.get().then((value) {
      if (value.size > 0) {
        value.docs.forEach((element) {
          _productItems[element.data().id] = element.data();
        });
      }
    });
  }

  Future<List<ProductItem?>> getProductsForCategory(String categoryName) async {
    if(_productItems.isEmpty)
      await loadProductItemsFromFirebase();
    return await productRef.where("category", isEqualTo: categoryName).get()
        .then((value) => value.docs.where((element) => _productItems.containsKey(element.data().id)).map((e) => _productItems[e.data().id])
        .toList());
  }

  Future<List<ProductItem?>> getProductsBySearchString(
      String searchString) async {
    if(_productItems.isEmpty)
      await loadProductItemsFromFirebase();
    return await productRef.where("search_params", arrayContains: searchString).get()
        .then((value) => value.docs.where((element) => _productItems.containsKey(element.data().id)).map((e) => _productItems[e.data().id])
        .toList());
  }

  Future<List<ProductItem?>> getProductsByTag(String tag) async {
    if(_productItems.isEmpty)
      await loadProductItemsFromFirebase();
    return await productRef.where("tags", arrayContains: tag).get()
        .then((value) => value.docs.where((element) => _productItems.containsKey(element.data().id)).map((e) => _productItems[e.data().id])
        .toList());
  }

  Future<ProductItem?> getProductById(String id) async {
    return (await productRef.doc(id).get()).data();
  }

  ProductItem? getProductByIdFromCache(String id)  {
    return _productItems[id];
  }
}
