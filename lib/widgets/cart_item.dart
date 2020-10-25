import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final String id;
  final String title;
  final double price;
  final int quantity;

  const CartItem(
      {this.id, this.title, this.price, this.quantity, this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
          '$title is removed from cart',
          style: TextStyle(fontSize: 16),
        )));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price')),
          ),
          title: Text('$title'),
          subtitle: Text('Total: ${(price * quantity)}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
