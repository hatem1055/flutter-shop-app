import 'package:flutter/material.dart';
import '../../providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem(this.product,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(backgroundImage:NetworkImage(
        product.imageUrl
      ),),
      trailing: Container(
        width: 100,
        child: Row(
          children:[
            IconButton(icon: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: (){},
            ),
            IconButton(
              icon:Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: (){},
            )
          ]
        ),
      ),
    );
  }
}