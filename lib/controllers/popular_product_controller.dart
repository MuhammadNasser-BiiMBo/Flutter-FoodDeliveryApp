import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/products_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  // the list of the popular products
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  // the value of the Items on the UI
  int _inCartItems = 0;
  int get inCartItems => _inCartItems+_quantity;

  late CartController _cart ;


  // used to get the list of the PopularProducts
  Future<void> getPopularProductList()async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode ==200){
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }else{}
  }

  // used to increase and decrease the number of items we want to add to the cart in the ui.
  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }

  // used to check whether the number of items 0 < items < 20 then return the quantity.
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar('Item count', 'You can\'t reduce more ',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity= -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>20){
      Get.snackbar('Item count', 'You can\'t add more ',
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }

  // user whenever we enter the ProductDetailsScreen for each product.
  void initProduct(ProductModel product,CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart ;
    var exist = false;
    exist = _cart.existInCart(product);
    // check if the cartItems exist in storage
    // get the cartItems from Storage
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    print('the quantity in the cart is $_inCartItems');
  }
  // to call the addItem function in CartController.
  void addItem(ProductModel product){
      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItems = _cart.getQuantity(product);
      update();
  }

  // to get the total items in the cart
  int get totalItems {
    return _cart.totalItems;
  }

  // to call the getter of the cart items from the CartController.
  List<CartModel> get getItems{
    return _cart.getItems;
  }
}