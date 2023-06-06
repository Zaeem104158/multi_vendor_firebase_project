import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

//Initialize
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  File? image;
  final picker = ImagePicker();
  List<XFile>? multipleImagesList = [];
  String mainCategoryValue = 'MainCategory';
  String subCategoryValue = 'SubCategory';
  List<String> subCategoryList = [];

//Upload Image Function
  uploadProductImageListToFirebase(
      {File? imageFile,
      List<XFile>? multipleImageList,
      bool isMultiImage = false,
      String? directoryName}) async {
    String downloadUrl = "";
    List<String> downloadUrlList = [];

    for (var element in multipleImageList!) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageRef =
          firebaseStorage.ref().child('$productImageDirectory/$fileName');
      File elementPath = File(element.path);
      final UploadTask uploadTask = storageRef.putFile(elementPath);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrlList.add(downloadUrl);
    }
    return downloadUrlList;
  }

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
    if (selleSId != '' &&
        mainCategoryValue != '' &&
        subCategoryValue != '' &&
        multipleImagesList!.isNotEmpty &&
        productNameController.text != '' &&
        productQuantityController.text != '' &&
        productPriceController.text != '' &&
        productDiscountController.text != '' &&
        productDescriptionController.text != '') {
      Future<dynamic> futureDynamicList = uploadProductImageListToFirebase(
          isMultiImage: true,
          multipleImageList: multipleImagesList,
          directoryName: productImageDirectory);
      List<dynamic> productImageFileList = await futureDynamicList;

      print("Check here::${productImageFileList.runtimeType}");
      CollectionReference productReference =
          firestore.collection(directoryName!);
      await productReference.doc().set({
        sellerCollectionFieldSid: selleSId,
        productCollectionFieldMainCategory: mainCategory,
        productCollectionFieldSubCategory: subCategory,
        productCollectionFieldProductName: productName,
        productCollectionFieldProductDescription: productDescription,
        productCollectionFieldProductPrice: productPrice,
        productCollectionFieldProductInStock: productQuantity,
        productCollectionFieldProductImageFile: productImageFileList,
        productCollectionFieldProductDiscount: productDiscount,
      }).whenComplete(() => null);

      dismissLoading();
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
