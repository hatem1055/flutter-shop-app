import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'products_grid.dart';
import 'badge_widget.dart';
import '../../providers/cart_provider.dart';

enum FilterOptions { Favourits, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showOnlyFavourits = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: [
            Consumer<CartProvider>(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
                builder: (_, cart, child) {
                  return Badge(child: child, value: cart.itemCount.toString());
                }),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (value) => {
                setState(() {
                  if (value == FilterOptions.Favourits) {
                    _showOnlyFavourits = true;
                  } else {
                    _showOnlyFavourits = false;
                  }
                })
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favourits'),
                  value: FilterOptions.Favourits,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                )
              ],
            )
          ],
        ),
        body: ProductsGrid(_showOnlyFavourits));
  }
}
