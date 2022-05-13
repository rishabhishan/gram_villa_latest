import 'package:flutter/widgets.dart';
import 'package:gram_villa_latest/dao/cart_dao.dart';
import 'package:gram_villa_latest/dao/category_dao.dart';
import 'package:gram_villa_latest/dao/order_dao.dart';
import 'package:gram_villa_latest/dao/product_dao.dart';
import 'package:gram_villa_latest/models/address.dart';
import 'package:gram_villa_latest/models/order.dart';
import 'package:gram_villa_latest/models/product_category.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../Constants.dart';
import 'auth_service.dart';

class DBService {
  static final DBService _dbService = DBService._internal();
  CategoryDao categoryDao = CategoryDao();
  ProductDao productDao = ProductDao();
  OrderDao orderDao = OrderDao();

  factory DBService() {
    return _dbService;
  }

  DBService._internal();

  Future<List<ProductCategory>> getCategories() async {
    return categoryDao.getCategories();
  }

  Future<List<Order>> getOrders(String uid) async {
    return await orderDao.getOrdersForUser(uid);
  }

  Future<List<ProductItem?>> getProductsForCategory(String categoryName, BuildContext context) async {
    return await Provider.of<ProductDao>(context, listen: false).getProductsForCategory(categoryName);
  }

  Future<List<ProductItem?>> getProductsBySearchString(
      String searchString, BuildContext context) async {
    return await Provider.of<ProductDao>(context, listen: false).getProductsBySearchString(searchString);
  }

  Future<List<ProductItem?>> getProductsByTag(String tag, BuildContext context) async {
    return await Provider.of<ProductDao>(context, listen: false).getProductsByTag(tag);
  }

  Future<bool> placeOrder(BuildContext context, Order order) async {
    CartDao cartDao = Provider.of<CartDao>(context, listen: false);

    bool saveOrder = await OrderDao().saveOrder(order);
    if(saveOrder){
      cartDao.clearCart(context);
    }
    return true;
  }
}
