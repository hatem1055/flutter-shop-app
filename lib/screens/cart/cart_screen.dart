import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import 'cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
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
                    FlatButton(
                      child: Text('Order Now'),
                      onPressed: (){},
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                )),
          ),
          SizedBox(height:10),
          Expanded(child:ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (ctx,index){
              return CartItemWidget(cart.items.values.toList()[index],cart.items.keys.toList()[index]);
            },
          ))
        ],
      ),
    );
  }
}
