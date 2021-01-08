import 'package:flutter/material.dart';
import '../orders/orders_screen.dart';
import '../user_products/user_products_screen.dart';
class MyDrawer extends StatelessWidget {
  Widget drawerItem(BuildContext context,String title, IconData icon,String route) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          drawerItem(context,'Shop', Icons.shop,'/'),
          Divider(),
          drawerItem(context,'Orders', Icons.credit_card,OrdersScreen.routeName),
          Divider(),
          drawerItem(context, 'Manage products', Icons.edit, UserProductsScreen.route)
        ],
      ),
    );
  }
}
