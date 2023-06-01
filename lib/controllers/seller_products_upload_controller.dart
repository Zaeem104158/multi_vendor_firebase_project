import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerProductsUploadController {
  final TextEditingController productNameController = TextEditingController();

  final TextEditingController productPriceController = TextEditingController();

  final TextEditingController productQuantityController =
      TextEditingController();

  final TextEditingController productDescriptionController =
      TextEditingController();
  File? image;
  final picker = ImagePicker();
  List<XFile> multipleImages = [];
  String mainCategoryValue = 'Main';
  String subCategoryValue = 'Sub';
  List<String> subCategoryList = [];

  void uploadProduct() {
    if (mainCategoryValue != '' &&
        subCategoryValue != '' &&
        multipleImages.isNotEmpty &&
        productNameController.text != '' &&
        productQuantityController.text != '' &&
        productPriceController.text != '' &&
        productDescriptionController.text != '') {
      //log("All ok: $mainCategoryValue $subCategoryValue $multipleImages ${productNameController.text} ${productQuantityController.text} ${productPriceController.text} ${productDescriptionController.text} ");
    } else {
      log("All not ok");
    }
  }

  bool isValidateUpload() {
    if (mainCategoryValue != '' &&
        subCategoryValue != '' &&
        multipleImages.isNotEmpty &&
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
