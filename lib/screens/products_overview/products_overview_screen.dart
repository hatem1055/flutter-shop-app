import 'package:flutter/material.dart';
import 'products_grid.dart';
class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Products')),
        body: ProductsGrid());
  }
}


