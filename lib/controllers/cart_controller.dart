import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../models/cart_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int,CartModel> _items = {};
  Map<int,CartModel> get items => _items;

  void addItem(ProductModel product,int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(product.id)){
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity!+quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          img: value.img,
          price: value.price,
          quantity: value.quantity!+quantity,
          time: DateTime.now().toString(),
          isExist: true,
        );
      }
      );
      if(totalQuantity <=0){
        _items.remove(product.id!);
      }
    }else{
      if(quantity>0){
        _items.putIfAbsent(product.id!, () => CartModel(
            id: product.id,
            name: product.name,
            img: product.img,
            price: product.price,
            quantity: quantity,
            time: DateTime.now().toString(),
            isExist: true
        )
        );
      }else{
        Get.snackbar('Item count', 'You should at least add an item in the cart !! ',
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
  }

  bool existInCart (ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if( key == product.id ){
          quantity = value.quantity!;
        }
      });
      return quantity;
    }
    return quantity;
  }
}