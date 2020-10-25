import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart' show Cart;
import 'package:my_shop/providers/orders.dart';
import 'package:my_shop/widgets/cart_item.dart';
import 'package:my_shop/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryTextTheme.headline1.color,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false)
                          .createOrder(cart.items.values.toList());
                      cart.clear();
                    },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CartItem(
                productId: cart.items.keys.toList()[i],
                id: cart.items.values.toList()[i].id,
                title: cart.items.values.toList()[i].title,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity),
            itemCount: cart.itemCount,
          ))
        ],
      ),
    );
  }
}
