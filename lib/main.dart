import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/orders.dart';
import './providers/cart.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/products_provider.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
          ).copyWith(secondary: Colors.deepOrange),
        ),
        //home: const MyHomePage(title: 'My Shop'),
        home: ProductsOverview(),
        routes: {
          ProductDetail.routeName: (context) => ProductDetail(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProdutsScreen.routeName: (context) => UserProdutsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen()
        },
      ),
    );
  }
}
