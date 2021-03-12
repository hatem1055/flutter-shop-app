import 'package:flutter/material.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';

void placeOrder(
    BuildContext context, CartProvider cart, OrdersProvider orders) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
              'are you sure you want to place this order and clear the cart'),
          actions: [
            TextButton(
                onPressed: () {
                  orders.addOrder(cart.items.values.toList(), cart.totalAmount);
                  cart.clearCart();
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    )),
                child: Text('yes,Iam sure')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).errorColor,
                )),
                child: Text('cancel'))
          ],
        );
      },
      barrierDismissible: true);
}
