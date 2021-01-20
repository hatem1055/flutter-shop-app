import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider.dart';
import 'user_product_item.dart';
import '../drawer/drawer.dart';
import '../edit_add_product/edit_add_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const route = '/user_products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditAddProductScreen.route);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.separated(
          separatorBuilder: (_,__){
            return Divider(
              thickness: .7,
            );
          },
          itemCount:productsData.products.length,
          itemBuilder: (_,i){
            return UserProductItem(productsData.products[i]);
          },
        ),
      ),
      drawer:MyDrawer(),
    );
  }
}
