import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);
  static const routeName = '/product-detail';

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _itemCount = 1;
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productDetail =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(productDetail.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.network(
                productDetail.imageUrl,
                fit: BoxFit.cover,
              ),
              height: 300,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                productDetail.title,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Text(
              '£${productDetail.price}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              productDetail.description,
              style: const TextStyle(fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _itemCount != 1
                      ? IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => setState(() => _itemCount--),
                        )
                      : IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {},
                        ),
                  Text(
                    _itemCount.toString(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => _itemCount++),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                cart.addItem(
                  productDetail.id,
                  productDetail.price,
                  productDetail.title,
                  productDetail.imageUrl,
                  _itemCount,
                );
              },
              child: const Text(
                'Add To Cart',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
