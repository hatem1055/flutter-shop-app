import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../providers/orders_provider.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem order;
  OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var isExpaneded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$${widget.order.amount}'),
          subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime)),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                isExpaneded = !isExpaneded;
              });
            },
            icon: Icon(isExpaneded ? Icons.expand_less : Icons.expand_more),
          ),
        ),
        if (isExpaneded)
          Container(
            padding: EdgeInsets.symmetric(horizontal:15,vertical:4),
            height: min(widget.order.products.length * 20.0 + 40, 180),
            child: ListView(
              children: widget.order.products
                  .map((product) => Container(
                    margin: EdgeInsets.symmetric(vertical:5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(product.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            '${product.quantity}x \$${product.price}',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          )
                        ]),
                  ))
                  .toList(),
            ),
          )
      ]),
    );
  }
}
