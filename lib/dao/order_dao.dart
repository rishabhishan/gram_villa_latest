import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gram_villa_latest/models/order.dart';
import 'package:gram_villa_latest/models/product_item.dart';

class OrderDao {
  final orderRef =
      FirebaseFirestore.instance.collection('orders').withConverter<Order>(
            fromFirestore: (snapshots, _) => Order.fromJson(snapshots.data()!),
            toFirestore: (order, _) => order.toJson(),
          );

  Future<bool> saveOrder(Order order) {
    return orderRef
        .doc(order.orderId)
        .set(order)
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  Future<List<Order>> getOrdersForUser(String uid) async {
    return (await orderRef.where("uid", isEqualTo: uid).get())
        .docs
        .map((e) => e.data())
        .toList();
  }
}
