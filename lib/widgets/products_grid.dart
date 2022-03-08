import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavoitesOnly;
  ProductsGrid(this.showFavoitesOnly);

  /* const ProductsGrid({
    Key? key,
    required this.loadedProducts,
  }) : super(key: key);

  final List<Product> loadedProducts; */

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavoitesOnly ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        //create: (context) => products[index],
        child: ProductItem(
            /* products[index].id,
          products[index].title,
          products[index].imageUrl, */
            ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
