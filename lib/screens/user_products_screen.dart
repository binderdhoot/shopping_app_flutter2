//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/user_products.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product_screen.dart';

class UserProdutsScreen extends StatelessWidget {
  const UserProdutsScreen({Key? key}) : super(key: key);
  static const routeName = '/user-products';

  Future<void> _refreshedProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshedProducts(context),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (ctx, i) => Column(
              children: [
                UserProducts(
                  products.items[i].id,
                  products.items[i].title,
                  products.items[i].imageUrl,
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: .8,
                ),
              ],
            ),
            itemCount: products.items.length,
          ),
        ),
      ),
    );
  }
}
