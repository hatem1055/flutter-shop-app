import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../product_details/product_details_screen.dart';
import '../../providers/product.dart';
import 'badge_widget.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    final CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    //methods
    void navigateToDetails(ctx) {
      Navigator.of(ctx)
          .pushNamed(ProductDetailsScreen.routeName, arguments: product);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            navigateToDetails(context);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                    icon: Icon(product.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      product.toggleFavourite();
                    },
                    color: Theme.of(context).accentColor,
                  )),
          trailing: cart.isInCart(product.id)
              ? Consumer<CartProvider>(
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      cart.addItem(product.id, product.price, product.title);
                    },
                  ),
                  builder: (_, cart, child) {
                    return Badge(
                      child: child,
                      value: cart.getProductQuanitiy(product.id).toString(),
                      color: Colors.white,
                    );
                  },
                )
              : IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    cart.addItem(product.id, product.price, product.title);
                  },
                  color: Theme.of(context).accentColor,
                ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
