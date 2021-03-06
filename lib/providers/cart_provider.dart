import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  int quantity = 1;
  final double price;
  final String imageUrl;

  CartItem({@required this.id, @required this.price, @required this.title,@required this.imageUrl});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  //getters
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  bool isInCart(id) {
    return _items.containsKey(id);
  }

  int getProductQuanitiy(id) {
    return _items[id].quantity;
  }

  //methods
  void addItem(
    String productId,
    double price,
    String title,
    String imageUrl
  ) {
    if (_items.containsKey(productId)) {
      _items.removeWhere((key, value) => key == productId);
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(), price: price, title: title,imageUrl:imageUrl));
    }
    notifyListeners();
  }

  void deleteItem(id) {
    _items.remove(id);
    notifyListeners();
  }

  void incrementItemQuantity(id) {
    _items[id].quantity += 1;
    notifyListeners();
  }

  void dicrementItemQuantity(id) {
    if(_items[id].quantity > 1){
      _items[id].quantity -= 1;
    }
    notifyListeners();
  }
  void clearCart(){
    _items = {};
    notifyListeners();
  }
  //calculations
  double get totalAmount {
    double sum = 0.0;
    _items.forEach((key, cartItem) {
      sum += cartItem.price * cartItem.quantity;
    });
    return sum;
  }
}
