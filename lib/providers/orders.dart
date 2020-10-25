import 'package:flutter/foundation.dart';
import 'package:my_shop/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void createOrder(List<CartItem> cartItems) {
    double amount = 0.0;
    cartItems.forEach((element) {
      amount += element.price * element.quantity;
    });
    _orders.add(OrderItem(
      id: DateTime.now().toString(),
      amount: amount,
      products: cartItems,
      dateTime: DateTime.now(),
    ));
    notifyListeners();
  }
}
