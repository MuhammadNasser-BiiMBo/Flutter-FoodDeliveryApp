import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  // add the item with the quantity in the items list(which contains the items in the Cart)
  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    // if the item is in the list , we update it with the new quantity.
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            img: value.img,
            price: value.price,
            quantity: value.quantity! + quantity,
            time: DateTime.now().toString(),
            isExist: true,
            product: product,
        );
      });
      //when we want to remove an item from cart
      if (totalQuantity <= 0) {
        _items.remove(product.id!);
      }
    } else {
      //when the item is not in the list so , we add it .
      if (quantity > 0) {
        _items.putIfAbsent(
            product.id!,
            () => CartModel(
                id: product.id,
                name: product.name,
                img: product.img,
                price: product.price,
                quantity: quantity,
                time: DateTime.now().toString(),
                isExist: true,
                product: product,
            ));
      } else {
        Get.snackbar(
          'Item count',
          'You should at least add an item in the cart !! ',
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    update();
  }

  // to check whether the item is in the list or not
  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
      return quantity;
    }
    return quantity;
  }

  // to get the total items in the cart to be showed on the UI
  int get totalItems {
    var total = 0;
    items.forEach((key, value) {
      total += value.quantity!;
    });
    return total;
  }

  // a getter of the list of products in the cart.
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  // a getter of the total price of the items in the cart.
  int get totalAmount{
    var total = 0 ;
    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
  }

}
