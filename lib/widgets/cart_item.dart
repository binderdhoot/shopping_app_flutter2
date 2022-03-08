// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  //const CartItem({Key? key}) : super(key: key);
  final String id;
  final String productId;
  final String title;
  final double price;
  final int qty;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.qty,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        //return Future.value(true);
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'Do you want to remove item from cart?',
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
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.network(imageUrl),
            ),
            title: Text(title),
            subtitle: Text('£${price} * ${qty} = £${(price * qty).toString()}'),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text(
                      'Do you want to remove item from cart?',
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
                          Provider.of<Cart>(context, listen: false)
                              .removeItem(productId);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
            ),
          ),
        ),
      ),
    );
  }
}
