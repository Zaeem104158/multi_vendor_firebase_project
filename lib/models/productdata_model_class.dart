import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';

class ProductDataModel {
  String? productName;
  String? productDescription;
  String? mainCategory;
  String? subCategory;
  String? productPrice;
  String? productInstock;
  String? productDiscount;
  String? productSid;
  String? productId;
  bool? productNew;
  List<String>? productImageFile;

  ProductDataModel(
      {this.productName,
      this.productDescription,
      this.mainCategory,
      this.subCategory,
      this.productPrice,
      this.productInstock,
      this.productDiscount,
      this.productSid,
      this.productNew,
      this.productId,
      this.productImageFile});

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
        productName: map[productCollectionFieldProductName],
        productDescription: map[productCollectionFieldProductDescription],
        mainCategory: map[productCollectionFieldMainCategory],
        subCategory: map[productCollectionFieldSubCategory],
        productPrice: map[productCollectionFieldProductPrice],
        productInstock: map[productCollectionFieldProductInStock],
        productDiscount: map[productCollectionFieldProductDiscount],
        productSid: map[sellerCollectionFieldSid],
        productNew: map[sellerCollectionFieldIsProductNew],
        productId: map[productCollectionFieldProductId],
        productImageFile:
            map[productCollectionFieldProductImageFile].cast<String>());
  }
}
