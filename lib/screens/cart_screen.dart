import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../widgets/cart_item.dart' as ci; //or
import '../widgets/cart_item.dart';
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart-page';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text('£${cart.totalAmount}'),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      if (cart.itemCount > 0)
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        ),
                      cart.clearCart(),
                    },
                    child: Text(
                      cart.itemCount > 0 ? 'Order Now' : 'Cart Empty',
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: cart.itemCount > 0 ? Colors.green : Colors.grey,
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) => CartItem(
                id: cart.items.values.toList()[index].id,
                productId: cart.items.keys.toList()[index],
                title: cart.items.values.toList()[index].title,
                price: cart.items.values.toList()[index].price,
                qty: cart.items.values.toList()[index].qty,
                imageUrl: cart.items.values.toList()[index].imageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
