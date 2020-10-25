import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:my_shop/widgets/badge.dart';
import 'package:my_shop/widgets/main_drawer.dart';
import 'package:my_shop/widgets/products_gridview.dart';
import 'package:provider/provider.dart';

enum Filters {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                    child: Text('Only Favorites'), value: Filters.Favorites),
                PopupMenuItem(child: Text('Show All'), value: Filters.All),
              ];
            },
            onSelected: (value) {
              setState(() {
                if (value == Filters.Favorites) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: ProductsGridView(_showFavorites),
    );
  }
}
