import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerProductsUploadController {
  final TextEditingController productNameController = TextEditingController();

  final TextEditingController productPriceController = TextEditingController();

  final TextEditingController productQuantityController =
      TextEditingController();

  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productDiscountController =
      TextEditingController();

  File? image;
  final picker = ImagePicker();
  List<XFile>? multipleImagesList = [];
  String mainCategoryValue = 'MainCategory';
  String subCategoryValue = 'SubCategory';
  List<String> subCategoryList = [];

  void uploadProduct({
    String? directoryName,
    String? productName,
    String? productDescription,
    String? productPrice,
    String? productQuantity,
    String? mainCategory,
    String? subCategory,
    String? productDiscount,
    String? selleSId,
  }) async {
    loading();
    if (mainCategoryValue != '' &&
        subCategoryValue != '' &&
        multipleImagesList!.isNotEmpty &&
        productNameController.text != '' &&
        productQuantityController.text != '' &&
        productPriceController.text != '' &&
        productDiscountController.text != '' &&
        productDescriptionController.text != '') {
      // List<String> productImageFileList = uploadImageToFirebase(
      //     isMultiImage: true,
      //     multipleImageList: multipleImagesList,
      //     directoryName: productImageDirectory);
      // CollectionReference productReference =
      //     firestore.collection(directoryName!);
      // await productReference.doc().set({
      //   sellerCollectionFieldSid: selleSId,
      //   productCollectionFieldMainCategory: mainCategory,
      //   productCollectionFieldSubCategory: subCategory,
      //   productCollectionFieldProductName: productName,
      //   productCollectionFieldProductDescription: productDescription,
      //   productCollectionFieldProductPrice: productPrice,
      //   productCollectionFieldProductInStock: productQuantity,
      //   productCollectionFieldProductImageFile: productImageFileList,
      //   productCollectionFieldProductDiscount: productDiscount,
      // });

      // dismissLoading();
    } else {
      log("Product Upload Error");
    }
  }

  bool isValidateUpload() {
    if (mainCategoryValue != '' &&
        subCategoryValue != '' &&
        multipleImagesList!.isNotEmpty &&
        productNameController.text != '' &&
        productQuantityController.text != '' &&
        productPriceController.text != '' &&
        productDescriptionController.text != '') {
      return true;
    } else {
      return false;
    }
  }
}
