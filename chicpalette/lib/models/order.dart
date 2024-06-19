import 'package:cloud_firestore/cloud_firestore.dart';

class MyAppOrder {
  final String orderId;
  final String product;
  final double price;

  MyAppOrder({
    required this.orderId,
    required this.product,
    required this.price,
  });

  factory MyAppOrder.fromQueryDocumentSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return MyAppOrder(
      orderId: doc.get('orderId') ?? '',
      product: doc.get('product') ?? '',
      price: doc.get('price') ?? 0.0,
    );
  }
}