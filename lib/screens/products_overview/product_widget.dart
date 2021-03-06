import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../product_details/product_details_screen.dart';
import '../../providers/product.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    //methods
    void navigateToDetails(ctx) {
      Navigator.of(ctx)
          .pushNamed(ProductDetailsScreen.routeName, arguments: product);
    }

    void startSnackBar(String text, Function onPressed) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            onPressed(
                product.id, product.price, product.title, product.imageUrl);
          },
        ),
      ));
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
          trailing: Consumer<CartProvider>(
            builder: (_, cart, __) {
              return IconButton(
                icon: cart.isInCart(product.id)
                    ? Icon(Icons.shopping_cart)
                    : Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title,
                      product.imageUrl);
                      if(cart.isInCart(product.id)){
                        startSnackBar('Added to the cart', cart.addItem);
                      }else{
                        startSnackBar('Removed from cart', cart.addItem);
                      }
                },
                color: Theme.of(context).accentColor,
              );
            },
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
