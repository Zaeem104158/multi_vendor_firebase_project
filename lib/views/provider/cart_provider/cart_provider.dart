import 'package:firebase_multi_vendor_project/models/productdata_view_model.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CartProvider extends ChangeNotifier {
  List<ProductDataViewModel> _list = [];
  List<ProductDataViewModel> _orderList = [];

  List<ProductDataViewModel> get getItems {
    return _list;
  }

  int? get getCount {
    return _list.length;
  }

  void setOrderItems(List<ProductDataViewModel> _setlist) {
    _orderList.addAll(_setlist);
    notifyListeners();
  }

  List<ProductDataViewModel> get getOrderItems {
    return _orderList;
  }

  void addItem(context, {required ProductDataViewModel productData}) {
    ProductDataViewModel product = productData;
    _list.add(product);
    showSnack(context, AppLocalizations.of(context)!.product_added_in_cart);
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

  // Select or decelect

  void selectItem(String id) {
    final item = _list.firstWhere((element) => element.productId == id);
    item.isSelected = true;
    notifyListeners();
  }

  void deselectItem(String id) {
    final item = _list.firstWhere((element) => element.productId == id);
    item.isSelected = false;

    notifyListeners();
  }

  double get totalOrderPrice {
    var total = 0.00;
    for (var product in _orderList) {
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
}
