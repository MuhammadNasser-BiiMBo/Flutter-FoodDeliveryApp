import 'dart:convert';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({ required this.sharedPreferences});


  List<String> cart = [];
  List<String> cartHistory = [];

  // to save the cart items to sharedPreferences
  void addToCartList(List<CartModel> cartList){
    cart = [];
    // converts objects to strings as the shared preferences accepts only strings.
    for (var element in cartList) {
      element.time = DateTime.now().toString().substring(0,19);
      cart.add(jsonEncode(element));
    }
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
  }

  // to get the list of CartModel from sharedPreferences
  List<CartModel> getCartList(){
    List<String>  stringList= [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      stringList= sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    for (var element in stringList) { 
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  // add the contents of the cart to the Cart history when we press checkout
  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i = 0; i<cart.length;i++){
      cartHistory.add(cart[i]);
    }
    // to remove the contents of the cart (sharedPreferences) as it's added to the carHistory list.
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  //get the list of the history
  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory =[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory =[];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }


  // removing the cart sharedPreferences.
  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
  // to remove all the cart and cart history items when logged out.
  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }


}