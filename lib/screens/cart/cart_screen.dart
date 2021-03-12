import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/orders_provider.dart';
import '../../providers/cart_provider.dart';
import 'cart_item_widget.dart';
import '../drawer/drawer.dart';
import '../../general_widgets/confirmation_dialog.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final orders = Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color,
                          )),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      child: Text('Order Now'),
                      onPressed: () {
                        showConfirmationDialog(
                            context: context,
                            confirmFunction: () {
                              orders.addOrder(
                                  cart.items.values.toList(), cart.totalAmount);
                              cart.clearCart();
                            },
                            dismissFunction: (){},
                            message: 'are you sure you want to place this order and clear the cart'
                          );
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor)),
                    )
                  ],
                )),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (ctx, index) {
              return CartItemWidget(cart.items.values.toList()[index],
                  cart.items.keys.toList()[index]);
            },
          ))
        ],
      ),
    );
  }
}
