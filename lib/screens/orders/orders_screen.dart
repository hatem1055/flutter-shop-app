import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../drawer/drawer.dart';
import 'order_item.dart';
import '../../providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';  
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      drawer: MyDrawer(),
      appBar:AppBar(
        title: Text('Your Orders'),
      ),
      body:ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx,i){
          return OrderItemWidget(ordersData.orders[i]);
        },
      ),
    );
  }
}