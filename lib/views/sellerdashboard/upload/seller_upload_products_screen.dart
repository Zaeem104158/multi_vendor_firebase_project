import 'dart:developer';
import 'dart:io';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/components/text_formfield_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/controllers/seller_products_upload_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/sellerdashboard/upload/seller_category_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerUploadProductsScreen extends StatefulWidget {
  SellerUploadProductsScreen({super.key});

  @override
  State<SellerUploadProductsScreen> createState() =>
      _SellerUploadProductsScreenState();
}

class _SellerUploadProductsScreenState
    extends State<SellerUploadProductsScreen> {
  final SellerProductsUploadController _sellerProductsUploadController =
      SellerProductsUploadController();
  final AuthController _authController = AuthController();

  Future getImage(ImageSource source, {bool isMultipleImages = false}) async {
    try {
      if (!isMultipleImages) {
        final pickedFile = await _sellerProductsUploadController.picker
            .pickImage(source: source);
        setState(() {
          if (pickedFile != null) {
            _sellerProductsUploadController.image = File(pickedFile.path);
            // log("Image path : $_image");
          } else {
            log('No image selected.');
          }
        });
      } else {
        final pickedFiles =
            await _sellerProductsUploadController.picker.pickMultiImage();
        setState(() {
          if (pickedFiles.length != 0) {
            _sellerProductsUploadController.multipleImages = pickedFiles;
            log("Image paths: ${_sellerProductsUploadController.multipleImages}");
          } else {
            log('No image selected.');
          }
        });
      }
    } catch (e) {
      log("Something went wrong");
    }
  }

  void selectCatagory(String? value) {
    _sellerProductsUploadController.mainCategoryValue = value!;
    if (_sellerProductsUploadController.mainCategoryValue == 'Men') {
      setState(() {
        _sellerProductsUploadController.subCategoryValue = 'Shirt';
        _sellerProductsUploadController.subCategoryList = menSubCategoryList;
      });
    } else if (_sellerProductsUploadController.mainCategoryValue == 'Women') {
      setState(() {
        _sellerProductsUploadController.subCategoryValue = 'Sharee';
        _sellerProductsUploadController.subCategoryList = womenSubCategoryList;
      });
    } else if (_sellerProductsUploadController.mainCategoryValue == 'Kids') {
      setState(() {
        _sellerProductsUploadController.subCategoryValue = 'Shirt';
        _sellerProductsUploadController.subCategoryList = kidsSubCategoryList;
      });
    } else if (_sellerProductsUploadController.mainCategoryValue ==
        'Electornics') {
      setState(() {
        _sellerProductsUploadController.subCategoryValue = 'Phone';
        _sellerProductsUploadController.subCategoryList =
            electornicsSubCategoryList;
      });
    } else if (_sellerProductsUploadController.mainCategoryValue == 'Shoes') {
      setState(() {
        _sellerProductsUploadController.subCategoryValue = 'Men';
        _sellerProductsUploadController.subCategoryList = shoesSubCategoryList;
      });
    } else if (_sellerProductsUploadController.mainCategoryValue == 'Beauty') {
      setState(() {
        _sellerProductsUploadController.subCategoryValue = 'Man';
        _sellerProductsUploadController.subCategoryList = beautySubCategoryList;
      });
    } else if (_sellerProductsUploadController.mainCategoryValue ==
        'Accessories') {
      setState(() {
        _sellerProductsUploadController.subCategoryValue = 'HeadPhone';
        _sellerProductsUploadController.subCategoryList =
            accessoriesSubCategoryList;
      });
    }
  }
  // void selectCatagory(String? value) {
  //   if (_sellerProductsUploadController.mainCategoryValue == 'Main') {
  //     _sellerProductsUploadController.mainCategoryValue = mainCategoryList[1];
  //   } else {}
  // }

  Widget displayMultipleImages() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _sellerProductsUploadController.multipleImages.length,
        itemBuilder: (context, int index) {
          return Image.file(
            File(_sellerProductsUploadController.multipleImages[index].path),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: customHeightWidth(context, height: true) * 0.3,
                    width: customHeightWidth(context, width: true) * 0.5,
                    color: blueGreyColor.withOpacity(0.9),
                    child: _sellerProductsUploadController
                                .multipleImages.isNotEmpty &&
                            _sellerProductsUploadController.image == null
                        ? displayMultipleImages()
                        : CustomTextComponet(
                            isClickAble: false,
                            isCenterText: true,
                            textTitle: "You haven't pick \n \nany image",
                            fontColor: blackColor,
                            fontWeight: regularBoldFontWeight,
                            fontSize: regularTextSize,
                          ),
                  ),
                  Column(
                    children: [
                      //Main Category
                      CustomTextComponet(
                        textTitle: "Select Category\nHere",
                        textPadding: EdgeInsets.all(4),
                        fontWeight: regularBoldFontWeight,
                        fontSize: regularTextSize,
                      ),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(20),
                        value:
                            _sellerProductsUploadController.mainCategoryValue,
                        onChanged: (String? newValue) {
                          selectCatagory(newValue);
                        },
                        items: mainCategoryList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CustomTextComponet(
                              textTitle: "$value".toUpperCase(),
                              textPadding: EdgeInsets.all(2),
                              fontWeight: regularFontWeight,
                              fontSize: mediumTextSize,
                              isCenterText: true,
                              isClickAble: true,
                            ),
                          );
                        }).toList(),
                      ),
                      //Sub Category
                      CustomTextComponet(
                        textTitle: "Select Sub\nCategory Here",
                        textPadding: EdgeInsets.all(4),
                        fontWeight: regularBoldFontWeight,
                        fontSize: regularTextSize,
                      ),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(20),
                        value: _sellerProductsUploadController.subCategoryValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _sellerProductsUploadController.subCategoryValue =
                                newValue!;
                          });
                        },
                        items: _sellerProductsUploadController.subCategoryList
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CustomTextComponet(
                              textTitle: "$value".toUpperCase(),
                              textPadding: EdgeInsets.all(2),
                              isCenterText: true,
                              isClickAble: true,
                            ),
                          );
                        }).toList(),
                      ),
                      ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(blackColor)),
                          onPressed: () {
                            setState(() {
                              _sellerProductsUploadController.multipleImages =
                                  [];
                            });
                          },
                          icon: Icon(Icons.delete_forever),
                          label: CustomTextComponet(
                            isCenterText: true,
                            isClickAble: true,
                            fontColor: whiteColor,
                            textTitle: "Delete Image",
                          ))
                    ],
                  ),
                ],
              ),
              Divider(
                color: cyanColor,
                thickness: 2,
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel: "Product Name",
                maxLine: 2,
                isEmail: false,
                formFieldLabelColor: blackColor,
                formFieldLabelWeight: FontWeight.bold,
                formFieldLabelPadding: EdgeInsets.all(2),
                formFieldLabelSize: 16,
                formFieldHintColor: blackColor.withOpacity(0.4),
                formFieldHintSize: 12,
                formFieldHintWeight: FontWeight.bold,
                formFieldhHintText: "Enter your product name",
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController:
                    _sellerProductsUploadController.productNameController,
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel: "Quantity",
                maxLine: 1,
                isEmail: false,
                keyboardType: TextInputType.number,
                formFieldLabelColor: blackColor,
                formFieldLabelWeight: FontWeight.bold,
                formFieldLabelPadding: EdgeInsets.all(2),
                formFieldLabelSize: 16,
                formFieldHintColor: blackColor.withOpacity(0.4),
                formFieldHintSize: 12,
                formFieldHintWeight: FontWeight.bold,
                formFieldhHintText: "Enter your product quantity",
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController:
                    _sellerProductsUploadController.productQuantityController,
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel: "Price",
                maxLenght: 10,
                maxLine: 1,
                isEmail: false,
                keyboardType: TextInputType.number,
                formFieldLabelColor: blackColor,
                formFieldLabelWeight: FontWeight.bold,
                formFieldLabelPadding: EdgeInsets.all(2),
                formFieldLabelSize: 16,
                formFieldHintColor: blackColor.withOpacity(0.4),
                formFieldHintSize: 12,
                formFieldHintWeight: FontWeight.bold,
                formFieldhHintText: "Enter your product price",
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController:
                    _sellerProductsUploadController.productPriceController,
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel: "Description",
                maxLenght: 300,
                maxLine: 5,
                isEmail: false,
                isValidate: true,
                formFieldLabelColor: blackColor,
                formFieldLabelWeight: FontWeight.bold,
                formFieldLabelPadding: EdgeInsets.all(2),
                formFieldLabelSize: 16,
                formFieldHintColor: blackColor.withOpacity(0.4),
                formFieldHintSize: 12,
                formFieldHintWeight: FontWeight.bold,
                formFieldhHintText: "Enter your product description",
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController: _sellerProductsUploadController
                    .productDescriptionController,
              ),
              CustomTextComponet(
                textTitle: "Logout",
                onPressed: () => _authController.logoutSeller(context),
                isClickAble: true,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                getImage(ImageSource.gallery, isMultipleImages: true);
              },
              backgroundColor: blackColor,
              child: Icon(
                Icons.photo_library,
                color: whiteColor,
              ),
            ),
            CustomSizedBox(
              width: customHeightWidth(context, width: true) * 0.05,
            ),
            FloatingActionButton(
              heroTag: null,
              backgroundColor:
                  _sellerProductsUploadController.isValidateUpload()
                      ? blackColor
                      : greyColor,
              onPressed: () {
                _sellerProductsUploadController.uploadProduct();
              },
              child: Icon(
                Icons.upload,
                color: whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
