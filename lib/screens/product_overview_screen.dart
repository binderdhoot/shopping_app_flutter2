import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products_provider.dart';

class ProductsOverview extends StatefulWidget {
  const ProductsOverview({Key? key}) : super(key: key);

  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _showOnlyFavourite = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts(); // if this will not work you may use another approach like
    /* Future.delayed(Duration.zero).then(
      (value) => {
        Provider.of<Products>(context).fetchAndSetProducts(),
      },
    ); */ //another way is didChangeDependencies
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Products>(context).fetchAndSetProducts().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final productsList = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (int value) => {
              setState(
                () => {
                  if (value == 0)
                    {
                      //productsList.showFavourotesOnly()
                      _showOnlyFavourite = true
                    }
                  else
                    {
                      //productsList.showAll()
                      _showOnlyFavourite = false
                    }
                },
              ),
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Only Favourite'), value: 0),
              const PopupMenuItem(child: Text('Show All'), value: 1),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cartData, child) => Badge(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              value: cartData.itemCount.toString(),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavourite),
    );
  }
}
