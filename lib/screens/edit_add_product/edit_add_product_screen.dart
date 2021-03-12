import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/product.dart';
import '../../providers/products_provider.dart';

class LocalControllers {
  final imageUrlController = TextEditingController();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  void controllersDispose() {
    imageUrlController.dispose();
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
  }

  void setControllersValues(Product product) {
    imageUrlController.text = product.imageUrl;
    descriptionController.text = product.description;
    priceController.text = product.price.toString();
    titleController.text = product.title;
  }
}

class EditAddProductScreen extends StatefulWidget {
  static const route = '/editAddProduct';
  @override
  _EditAddProductScreenState createState() => _EditAddProductScreenState();
}

class _EditAddProductScreenState extends State<EditAddProductScreen> {
  final controllers = LocalControllers();
  final imageUrlFocusNode = FocusNode();
  final inputsMargin = const EdgeInsets.symmetric(vertical: 15, horizontal: 10);
  final form = GlobalKey<FormState>();
  var editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var isinit = true;

  @override
  void initState() {
    imageUrlFocusNode.addListener(updateUrl);
    super.initState();
  }

  @override
  void dispose() {
    controllers.controllersDispose();
    imageUrlFocusNode.removeListener(updateUrl);
    imageUrlFocusNode.dispose();
    super.dispose();
  }

  void updateUrl() {
    if (imageUrlFocusNode.hasFocus == false) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (isinit) {
      final oldProduct = ModalRoute.of(context).settings.arguments as Product;
      editedProduct = oldProduct == null ? editedProduct : oldProduct;
      controllers.setControllersValues(editedProduct);
    }
    isinit = false;
    super.didChangeDependencies();
  }

  void saveForm() {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }
    form.currentState.save();
    Provider.of<ProductsProvider>(context, listen: false)
        .editAddProduct(editedProduct);
    Navigator.of(context).pop();
  }

  InputDecoration singleLineInputStyle(label) => InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveForm,
          )
        ],
      ),
      body: Form(
          key: form,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                margin: inputsMargin,
                child: TextFormField(
                  decoration: singleLineInputStyle('Title'),
                  controller: controllers.titleController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please provide a vlue';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    editedProduct = Product(
                        id: editedProduct.id,
                        title: val,
                        description: editedProduct.description,
                        price: editedProduct.price,
                        imageUrl: editedProduct.imageUrl,
                        isFavourite: editedProduct.isFavourite,);
                  },
                ),
              ),
              Container(
                margin: inputsMargin,
                child: TextFormField(
                  decoration: singleLineInputStyle('Price'),
                  controller: controllers.priceController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSaved: (val) {
                    editedProduct = Product(
                        id: editedProduct.id,
                        title: editedProduct.title,
                        description: editedProduct.description,
                        price: double.tryParse(val),
                        imageUrl: editedProduct.imageUrl,
                        isFavourite: editedProduct.isFavourite,);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please provide a value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'please enter a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'please enter a number greater than zero';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: inputsMargin,
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: controllers.imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                            controllers.imageUrlController.text,
                            fit: BoxFit.cover,
                          )),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: singleLineInputStyle('Image URL'),
                      controller: controllers.imageUrlController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      focusNode: imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please provide a vlue';
                        }

                        if (!Uri.parse(value).isAbsolute) {
                          return 'please enter valid url';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        editedProduct = Product(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: editedProduct.description,
                            price: editedProduct.price,
                            isFavourite: editedProduct.isFavourite,
                            imageUrl: val);
                      },
                    ),
                  ),
                ]),
              ),
              Container(
                margin: inputsMargin,
                child: TextFormField(
                  decoration: singleLineInputStyle('Description'),
                  controller: controllers.descriptionController,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onFieldSubmitted: (_) => saveForm(),
                  onSaved: (val) {
                    editedProduct = Product(
                        id: editedProduct.id,
                        title: editedProduct.title,
                        description: val,
                        price: editedProduct.price,
                        imageUrl: editedProduct.imageUrl,
                        isFavourite: editedProduct.isFavourite,);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please provide a vlue';
                    }
                    if (value.length < 10) {
                      return 'Should be greater than 10 chars.';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: inputsMargin,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveForm,
                  child: Text(
                    'submit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(color: Colors.grey)))),
                  // shape:
                ),
              )
            ]),
          )),
    );
  }
}
