import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart/counter.dart';
import '../../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final String productId;
  final CartItem cartItem;
  CartItemWidget(this.cartItem, this.productId);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (dir) => {
        Provider.of<CartProvider>(context, listen: false).deleteItems(productId)
      },
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: EdgeInsets.only(right: 20),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
      ),
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(cartItem.imageUrl), fit: BoxFit.fill),
                ),
              ),
              title: Text(cartItem.title),
              subtitle: Text(
                  'total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
              trailing: CounterWidget(cartItem.quantity, productId),
            ),
          )),
    );
  }
}
