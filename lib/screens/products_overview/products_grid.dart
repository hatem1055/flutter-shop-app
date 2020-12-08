import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider.dart';
import 'product_widget.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: productsData.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (_, index) {
          return ChangeNotifierProvider.value(
          value:productsData.products[index],
          child: ProductWidget(),
          
          ) ;
        });
  }
}