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
  String mainCategoryValue = 'Men';
  String subCategoryValue = 'Shirt';
  List<String> subCategoryList = [];
}
