import 'package:flutter/material.dart';
import 'package:shoppy/screens/product_details/product_details_screen.dart';
import 'screens/products_overview/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoppy',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor:Colors.deepOrange,
        fontFamily: 'Lato'
      ),
      routes: {
        '/': (ctx) => ProductOverviewScreen(),
        ProductDetailsScreen.routeName:(ctx) => ProductDetailsScreen()
      },
    );
  }
}


