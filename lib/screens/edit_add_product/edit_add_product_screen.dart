import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditAddProductScreen extends StatefulWidget {
  static const route = '/editAddProduct';
  @override
  _EditAddProductScreenState createState() => _EditAddProductScreenState();
}

class _EditAddProductScreenState extends State<EditAddProductScreen> {
  final imageUrlController = TextEditingController();
  final imageUrlFocusNode = FocusNode();
  final inputsMargin = const EdgeInsets.symmetric(vertical: 15, horizontal: 10);

  @override
  void initState() {
    imageUrlFocusNode.addListener(updateUrl);
    super.initState();
  }

  @override
  void dispose() {
    imageUrlController.dispose();
    imageUrlFocusNode.dispose();
    imageUrlFocusNode.removeListener(updateUrl);
    super.dispose();
  }

  void updateUrl() {
    if (imageUrlFocusNode.hasFocus == false) {
      setState(() {});
    }
  }

  InputDecoration singleLineInputStyle(label) => InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: inputsMargin,
            child: TextFormField(
              decoration: singleLineInputStyle('Title'),
              textInputAction: TextInputAction.next,
            ),
          ),
          Container(
            margin: inputsMargin,
            child: TextFormField(
              decoration: singleLineInputStyle('Price'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
          ),
          Container(
            margin: inputsMargin,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 8, right: 5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                child: imageUrlController.text.isEmpty
                    ? Text('Enter a URL')
                    : FittedBox(
                        child: Image.network(
                        imageUrlController.text,
                        fit: BoxFit.cover,
                      )),
              ),
              Expanded(
                child: TextFormField(
                  decoration: singleLineInputStyle('Image URL'),
                  controller: imageUrlController,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  focusNode: imageUrlFocusNode,
                  onFieldSubmitted: (_) {
                    setState(() {});
                  },
                ),
              ),
            ]),
          ),
          Container(
            margin: inputsMargin,
            child: TextFormField(
              decoration: singleLineInputStyle('Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),
          ),
          Container(
            margin: inputsMargin,
            width: double.infinity,
            child: RaisedButton(
                onPressed: () {},
                child: Text('submit',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400
                ),),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: Colors.grey))),
          )
        ]),
      )),
    );
  }
}
