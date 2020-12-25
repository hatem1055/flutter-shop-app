import 'package:flutter/material.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';
void placeOrder(BuildContext context,CartProvider cart,OrdersProvider orders) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
              'are you sure you want to place this order and clear the cart'),
          actions: [
            FlatButton(
                onPressed: () {
                  orders.addOrder(cart.items.values.toList(), cart.totalAmount);
                  cart.clearCart();
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('yes,Iam sure')),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: Theme.of(context).errorColor,
                child: Text('cancel'))
          ],
        );
      },
      barrierDismissible: true);
}