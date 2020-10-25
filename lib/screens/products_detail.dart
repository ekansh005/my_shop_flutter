import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

class ProductsDetail extends StatelessWidget {
  static String routeName = '/products-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                product.description,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
