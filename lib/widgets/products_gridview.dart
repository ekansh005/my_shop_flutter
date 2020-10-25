import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGridView extends StatelessWidget {
  final bool showFavorites;

  ProductsGridView(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts =
        showFavorites ? productsData.favorites : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        // create: (context) => loadedProducts[index],
        value: loadedProducts[index],
        child: ProductItem(),
      ),
    );
  }
}
