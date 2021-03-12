import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product.dart';
import '../edit_add_product/edit_add_product_screen.dart';
import '../../providers/products_provider.dart';
import '../../general_widgets/confirmation_dialog.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem(this.product, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditAddProductScreen.route, arguments: product);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
            onPressed: () {
              showConfirmationDialog(
                  context: context,
                  message: 'are you sure you want to delete this product',
                  confirmFunction: () {
                    Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProduct(product.id);
                  },
                  dismissFunction: () {});
            },
          )
        ]),
      ),
    );
  }
}
