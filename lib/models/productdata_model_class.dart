import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';

class ProductDataModelClass {
  String? productName;
  String? productDescription;
  String? mainCategory;
  String? subCategory;
  String? productPrice;
  String? productInstock;
  String? productDiscount;
  String? productSid;
  bool? productNew;
  List<String>? productImageFile;

  ProductDataModelClass(
      {this.productName,
      this.productDescription,
      this.mainCategory,
      this.subCategory,
      this.productPrice,
      this.productInstock,
      this.productDiscount,
      this.productSid,
      this.productNew,
      this.productImageFile});

  factory ProductDataModelClass.fromMap(Map<String, dynamic> map) {
    return ProductDataModelClass(
        productName: map[productCollectionFieldProductName],
        productDescription: map[productCollectionFieldProductDescription],
        mainCategory: map[productCollectionFieldMainCategory],
        subCategory: map[productCollectionFieldSubCategory],
        productPrice: map[productCollectionFieldProductPrice],
        productInstock: map[productCollectionFieldProductInStock],
        productDiscount: map[productCollectionFieldProductDiscount],
        productSid: map[sellerCollectionFieldSid],
        productNew: map[sellerCollectionFieldIsProductNew],
        productImageFile:
            map[productCollectionFieldProductImageFile].cast<String>());
  }
}
