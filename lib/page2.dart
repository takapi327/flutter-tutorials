import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: MyCatalog()
        )
      ],
    );
  }
}

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myCartSection(),
        addCartButton()
      ],
    );
  }

  Widget myCartSection() {
    return Consumer<CartModel>(
      builder: (context, cart, child) => Stack(
        children: [
          Text("Total price: ${cart.totalPrice}"),
        ],
      ),
    );
  }

  Widget addCartButton() {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Container(
          child: FlatButton(
            child: Text('Add'),
            onPressed: () {
              cart.add(new Item());
            }
          )
        );
      }
    );

  }
}

class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  }
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.length * 42;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
