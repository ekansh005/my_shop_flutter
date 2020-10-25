import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as orderModel;

class OrderItem extends StatefulWidget {
  final orderModel.OrderItem order;

  const OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
        ),
        if (_expanded)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            padding: EdgeInsets.all(10),
            height: min(widget.order.products.length * 20.0 + 30, 180),
            color: Colors.grey[200],
            child: ListView(
              children: widget.order.products
                  .map((product) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.title}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            '${product.quantity}x   \$${product.price}',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
