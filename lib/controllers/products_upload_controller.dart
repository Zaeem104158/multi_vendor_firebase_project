import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/views/category/category_list/category_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SellerProductsUploadController extends ChangeNotifier {
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
  File? _image;
  final picker = ImagePicker();
  List<XFile>? _multipleImagesList = [];
  String _mainCategoryValue = 'MainCategory';
  String _subCategoryValue = 'SubCategory';
  List<String> _subCategoryList = [];
  String _productName = '';
  String _productPrice = '';
  String _productQuantity = '';
  String _productDescription = '';
  String _productDiscount = '';

//Muilty Image getter and setter
  File? get image => _image;
  void setImage(File? image) {
    _image = image;
    notifyListeners();
  }

  List<XFile>? get multipleImagesList => _multipleImagesList;

  void setMulipleImagesList(List<XFile> pickedFiles) {
    _multipleImagesList = pickedFiles;
    notifyListeners();
  }

  Future getImage(ImageSource source, {bool isMultipleImages = false}) async {
    try {
      if (!isMultipleImages) {
        final pickedFile = await picker.pickImage(source: source);

        if (pickedFile != null) {
          setImage(File(pickedFile.path));
        } else {
          log('No image selected.');
        }
      } else {
        final pickedFiles = await picker.pickMultiImage();

        if (pickedFiles.length != 0) {
          setMulipleImagesList(pickedFiles);
        } else {
          log('No image selected.');
        }
      }
    } catch (e) {
      log("Something went wrong");
    }
    notifyListeners();
  }

  // Main Category getter and setter
  String get mainCategoryValue => _mainCategoryValue;
  void setMainCategoryValue(String? value) {
    _mainCategoryValue = value!;
    notifyListeners();
  }

// Sub Category Value getter and setter
  String get subCategoryValue => _subCategoryValue;
  void setSubCategoryValue(String? value) {
    _subCategoryValue = value!;
    notifyListeners();
  }

  // Select Subcategory List getter and setter.
  List<String> get subCategoryList => _subCategoryList;
  void setSubCategoryList(List<String> value) {
    _subCategoryList = value;
    notifyListeners();
  }

  void selectSubCatagoryList(String? value) {
    setMainCategoryValue(value);

    if (_mainCategoryValue == 'Men') {
      setSubCategoryList(menSubCategoryList);
    } else if (_mainCategoryValue == 'Women') {
      setSubCategoryList(womenSubCategoryList);
    } else if (_mainCategoryValue == 'Kids') {
      setSubCategoryList(kidsSubCategoryList);
    } else if (_mainCategoryValue == 'Electornics') {
      setSubCategoryList(electornicsSubCategoryList);
    } else if (_mainCategoryValue == 'Shoes') {
      setSubCategoryList(shoesSubCategoryList);
    } else if (_mainCategoryValue == 'Beauty') {
      setSubCategoryList(beautySubCategoryList);
    } else if (_mainCategoryValue == 'Accessories') {
      setSubCategoryList(accessoriesSubCategoryList);
    }
    setMainCategoryValue(value);
    setSubCategoryValue("SubCategory");
    notifyListeners();
  }

  // Validation
  String get productName => _productName;

  void setProductNameValue(String value) {
    _productName = value;
    notifyListeners();
  }

  String get productDescription => _productDescription;

  void setProductDescriptionValue(String value) {
    _productDescription = value;
    notifyListeners();
  }

  String get productPrice => _productPrice;

  void setProductPriceValue(String value) {
    _productPrice = value;
    notifyListeners();
  }

  String get productQuantity => _productQuantity;

  void setProductQuantityValue(String value) {
    _productQuantity = value;
    notifyListeners();
  }

  String get productDiscount => _productDiscount;

  void setProductDiscountValue(String value) {
    _productDiscount = value;
    notifyListeners();
  }

  bool get isSubmitButtonVisible {
    bool validate;
    _productName.isNotEmpty &&
            _productDescription.isNotEmpty &&
            _productPrice.isNotEmpty &&
            _productQuantity.isNotEmpty &&
            _productDiscount.isNotEmpty &&
            _mainCategoryValue != "MainCategory" &&
            _subCategoryValue != "SubCategory" &&
            _multipleImagesList!.length != 0
        ? validate = true
        : validate = false;
    return validate;
  }

//Upload Image Function
  uploadProductImageListToFirebase(
      {File? imageFile,
      List<XFile>? multipleImageList,
      bool isMultiImage = false,
      String? directoryName}) async {
    String downloadUrl = "";
    List<String> downloadUrlList = [];

    for (var element in multipleImageList!) {
      String fileName = Uuid().v4();
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

  // Upload Product
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
      String fileName = Uuid().v4();
      CollectionReference productReference =
          firestore.collection(directoryName!);
      try {
        await productReference.doc(fileName).set({
          productCollectionFieldProductId: fileName,
          sellerCollectionFieldSid: selleSId,
          productCollectionFieldMainCategory: mainCategory,
          productCollectionFieldSubCategory: subCategory,
          productCollectionFieldProductName: productName,
          productCollectionFieldProductDescription: productDescription,
          productCollectionFieldProductPrice: productPrice,
          productCollectionFieldProductInStock: productQuantity,
          productCollectionFieldProductImageFile: productImageFileList,
          productCollectionFieldProductDiscount: productDiscount,
          productCollectionFieldProductNew: true,
        });
        dismissLoading();
        showMessage("Product Uploaded", isToast: true);
      } catch (error) {
        showMessage("${error}", isInfo: true);
      }
    } else {
      log("Product Upload Error");
    }
  }

  // Clear Images
  void clearMultipleImageList() {
    _multipleImagesList = [];
    notifyListeners();
  }

  //CLear all
  void clearAll() {
    _mainCategoryValue = "MainCategory";
    _subCategoryValue = "SubCategory";
    _subCategoryList = [];
    clearMultipleImageList();
    productDescriptionController.clear();
    productDiscountController.clear();
    productQuantityController.clear();
    productPriceController.clear();
    productNameController.clear();
    _productName = '';
    _productPrice = '';
    _productQuantity = '';
    _productDiscount = '';
    _productDescription = '';
    notifyListeners();
  }

  //dispose
  void dispose() {
    productDescriptionController.dispose();
    productDiscountController.dispose();
    productQuantityController.dispose();
    productPriceController.dispose();
    productNameController.dispose();
    super.dispose();
  }
}
