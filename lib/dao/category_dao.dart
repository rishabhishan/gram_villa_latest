import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gram_villa_latest/models/product_category.dart';

class CategoryDao {
  final categoryRef = FirebaseFirestore.instance
      .collection('categories')
      .withConverter<ProductCategory>(
        fromFirestore: (snapshots, _) => ProductCategory.fromJson(snapshots.data()!),
        toFirestore: (category, _) => category.toJson(),
      );

  Future<List<ProductCategory>> getCategories() async {
    return (await categoryRef.get()).docs.map((e) => e.data()).toList();
  }

  addCategory(ProductCategory category) {
    return categoryRef.add(category);
  }

  deleteCategory(ProductCategory category) {
    return categoryRef.add(category);
  }

  Future<ProductCategory?> getCategory(String categoryId) async {
    return (await categoryRef.doc(categoryId).get()).data();
  }
}
