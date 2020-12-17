import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import '../../providers/products_provider.dart';
import 'product_widget.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavourits;
  ProductsGrid(this.showOnlyFavourits);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final List<Product> products = showOnlyFavourits
        ? productsData.favouriteProducts
        : productsData.products;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount:products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (_, index) {
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductWidget(),
          );
        });
  }
}
