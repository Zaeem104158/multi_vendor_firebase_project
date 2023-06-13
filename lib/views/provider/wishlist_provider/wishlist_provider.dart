import 'package:firebase_multi_vendor_project/models/productdata_view_model.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:flutter/material.dart';

class WishListProvider extends ChangeNotifier {
  List<ProductDataViewModel> _list = [];

  List<ProductDataViewModel> get getWishItems {
    return _list;
  }

  int? get getWishCount {
    return _list.length;
  }

  void addWishItem(context, {required ProductDataViewModel productData}) {
    //final product = ProductDataModel();
    ProductDataViewModel product = productData;
    _list.add(product);
    showSnack(context, "Product added in wishlist");
    notifyListeners();
  }

  void clearWishItem() {
    _list.clear();
    notifyListeners();
  }

  void removeFromWish(String id) {
    _list.removeWhere((element) => element.productId == id);
    notifyListeners();
  }

  void removeWishItem(ProductDataViewModel product) {
    _list.remove(product);
    notifyListeners();
  }
}
