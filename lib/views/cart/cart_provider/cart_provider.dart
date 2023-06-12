import 'package:firebase_multi_vendor_project/models/productdata_view_model.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<ProductDataViewModel> _list = [];

  List<ProductDataViewModel> get getItems {
    return _list;
  }

  int? get getCount {
    return _list.length;
  }

  void addItem(context, {required ProductDataViewModel productData}) {
    //final product = ProductDataModel();
    ProductDataViewModel product = productData;
    _list.add(product);
    showSnack(context, "Product added in cart");
    notifyListeners();
  }

  void increaseProduct(ProductDataViewModel product) {
    product.increaseQuentity();
    notifyListeners();
  }

  void decreaseProduct(ProductDataViewModel product) {
    product.decreaseQuentity();
    notifyListeners();
  }

  int recentInStock(ProductDataViewModel product) {
    int inStock = int.parse(product.productInstock!);
    // product.productInstock = inStock.toString();
    return inStock - product.selectQuantity;
  }

  double get totalPrice {
    var total = 0.00;
    for (var product in _list) {
      if (product.productDiscount! != "0") {
        int price = int.parse(product.productPrice!) -
            int.parse(product.productDiscount!);
        total += price * product.selectQuantity;
      } else {
        total += int.parse(product.productPrice!) * product.selectQuantity;
      }
    }
    return total;
  }

  void clearItem() {
    _list.clear();
    notifyListeners();
  }
}
