import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProducts extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProducts(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: const Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                    'Do you want to remove product?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Products>(context, listen: false)
                            .deleteProduct(id);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
