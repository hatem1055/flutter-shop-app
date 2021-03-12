import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

class CounterWidget extends StatelessWidget {
  final quantity;
  final productId;
  CounterWidget(this.quantity, this.productId);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final textStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 20);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (quantity > 1)
          TextButton(
            child: Text(
              '-',
              style: textStyle,
            ),
            onPressed: () {
              cart.dicrementItemQuantity(productId);
            },
            style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(Size.fromWidth(30))),
          ),
        Text('$quantity x'),
        TextButton(
          child: Text('+', style: textStyle),
          onPressed: () {
            cart.incrementItemQuantity(productId);
          },
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size.fromWidth(30))),
        ),
      ],
    );
  }
}
