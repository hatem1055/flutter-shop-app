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
        Provider.of<CartProvider>(context, listen: false).deleteItem(productId)
      },
      confirmDismiss: (_) {
        // confirm dissmis must return future bool and showdialog
        // return future with the value passed to navigator.pop
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Are you sure'),
                content: Text('Do you want to remove the item from the cart'),
                actions: [
                TextButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      }),
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            });
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
              leading: CircleAvatar(
                backgroundImage: NetworkImage(cartItem.imageUrl),
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
