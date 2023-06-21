import 'dart:io';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/components/text_formfield_component.dart';
import 'package:firebase_multi_vendor_project/controllers/products_upload_controller.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/category/category_list/category_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ProductUploadScreen extends StatelessWidget {
  ProductUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Consumer<SellerProductsUploadController>(
                  builder: (context, productCategoryProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: productCategoryProvider
                                    .multipleImagesList!.isNotEmpty &&
                                productCategoryProvider.image == null
                            ? displayMultipleImages(
                                context, productCategoryProvider)
                            : Container(
                                height:
                                    customHeightWidth(context, height: true) *
                                        0.3,
                                width: customHeightWidth(context, width: true) *
                                    0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: blueGreyColor.withOpacity(0.9),
                                ),
                                child: CustomTextComponet(
                                  isClickAble: false,
                                  isCenterText: true,
                                  textTitle: AppLocalizations.of(context)!
                                      .you_have_not_pick_any_images,
                                  maxLine: 3,
                                  fontColor: blackColor,
                                  fontWeight: regularBoldFontWeight,
                                  fontSize: regularTextSize,
                                ),
                              ),
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(blackColor)),
                            onPressed: () {
                              productCategoryProvider.clearAll();
                            },
                            icon: Icon(Icons.delete_forever),
                            label: CustomTextComponet(
                              isCenterText: true,
                              isClickAble: true,
                              fontColor: whiteColor,
                              textTitle:
                                  AppLocalizations.of(context)!.clear_all,
                            )),
                        Column(
                          children: [
                            //Main Category
                            CustomTextComponet(
                              textTitle: AppLocalizations.of(context)!
                                  .select_category_here,
                              textPadding: EdgeInsets.all(4),
                              maxLine: 2,
                              fontWeight: regularBoldFontWeight,
                              fontSize: regularTextSize,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: blackColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                dropdownColor: whiteColor,
                                underline: SizedBox(),
                                borderRadius: BorderRadius.circular(20),
                                value:
                                    productCategoryProvider.mainCategoryValue,
                                onChanged: (String? newValue) {
                                  productCategoryProvider
                                      .selectSubCatagoryList(newValue);
                                },
                                items: mainCategoryList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: CustomTextComponet(
                                      textTitle: "$value".toUpperCase(),
                                      textPadding: EdgeInsets.only(left: 4),
                                      fontWeight: regularBoldFontWeight,
                                      fontSize: smallTextSize,
                                      isCenterText: true,
                                      isClickAble: true,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            //Sub Category
                            CustomTextComponet(
                              textTitle: AppLocalizations.of(context)!
                                  .select_sub_category_here,
                              textPadding: EdgeInsets.all(4),
                              maxLine: 2,
                              fontWeight: regularBoldFontWeight,
                              fontSize: regularTextSize,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: blackColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                dropdownColor: whiteColor,
                                underline: SizedBox(),
                                borderRadius: BorderRadius.circular(20),
                                value: productCategoryProvider.subCategoryValue,
                                onChanged: (String? newValue) {
                                  productCategoryProvider
                                      .setSubCategoryValue(newValue);
                                },
                                items: productCategoryProvider.subCategoryList
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: CustomTextComponet(
                                      textTitle: "$value".toUpperCase(),
                                      textPadding: EdgeInsets.only(left: 4),
                                      fontWeight: regularBoldFontWeight,
                                      fontSize: smallTextSize,
                                      isCenterText: true,
                                      isClickAble: true,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }),
              Divider(
                color: cyanColor,
                thickness: 2,
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel: AppLocalizations.of(context)!.product_name,
                maxLine: 2,
                isEmail: false,
                formFieldLabelColor: blackColor,
                formFieldLabelWeight: FontWeight.bold,
                formFieldLabelPadding: EdgeInsets.all(2),
                formFieldLabelSize: 16,
                formFieldHintColor: blackColor.withOpacity(0.4),
                formFieldHintSize: 12,
                formFieldHintWeight: FontWeight.bold,
                formFieldhHintText:
                    AppLocalizations.of(context)!.enter_your_product_name,
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController: context
                    .read<SellerProductsUploadController>()
                    .productNameController,
                onChanged: (value) {
                  context
                      .read<SellerProductsUploadController>()
                      .setProductNameValue(value);
                },
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel: AppLocalizations.of(context)!.product_quantity,
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
                formFieldhHintText:
                    AppLocalizations.of(context)!.enter_your_product_quantity,
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController: context
                    .read<SellerProductsUploadController>()
                    .productQuantityController,
                onChanged: (value) {
                  context
                      .read<SellerProductsUploadController>()
                      .setProductQuantityValue(value);
                },
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel: AppLocalizations.of(context)!.product_price,
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
                formFieldhHintText:
                    AppLocalizations.of(context)!.enter_your_product_price,
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController: context
                    .read<SellerProductsUploadController>()
                    .productPriceController,
                onChanged: (value) {
                  context
                      .read<SellerProductsUploadController>()
                      .setProductPriceValue(value);
                },
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel: AppLocalizations.of(context)!.product_discount,
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
                formFieldhHintText:
                    AppLocalizations.of(context)!.enter_your_product_discount,
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController: context
                    .read<SellerProductsUploadController>()
                    .productDiscountController,
                onChanged: (value) {
                  context
                      .read<SellerProductsUploadController>()
                      .setProductDiscountValue(value);
                },
              ),
              CustomTextFormFieldComponent(
                padding: EdgeInsets.all(16.0),
                isBorderEnable: true,
                formFieldLabel:
                    AppLocalizations.of(context)!.product_description,
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
                formFieldhHintText: AppLocalizations.of(context)!
                    .enter_your_product_description,
                formFieldBorderRadius: 30.0,
                focusedBorderColor: Colors.green,
                focusedBorderWidth: 2,
                textEditingController: context
                    .read<SellerProductsUploadController>()
                    .productDescriptionController,
                onChanged: (value) {
                  context
                      .read<SellerProductsUploadController>()
                      .setProductDescriptionValue(value);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SellerProductsUploadController>(
            builder: (context, uploadProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  uploadProvider.getImage(ImageSource.gallery,
                      isMultipleImages: true);
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
              uploadProvider.isSubmitButtonVisible
                  ? FloatingActionButton(
                      heroTag: null,
                      backgroundColor: blackColor,
                      onPressed: () async {
                        dynamic sellerSid = await readFromSharedPreferences(
                            sharedPrefSellerUid);
                        uploadProvider.uploadProduct(
                          directoryName: productsDataDirectory,
                          mainCategory: uploadProvider.mainCategoryValue,
                          subCategory: uploadProvider.subCategoryValue,
                          productName:
                              uploadProvider.productNameController.text,
                          productDiscount:
                              uploadProvider.productDiscountController.text,
                          productPrice:
                              uploadProvider.productPriceController.text,
                          productDescription:
                              uploadProvider.productDescriptionController.text,
                          productQuantity:
                              uploadProvider.productQuantityController.text,
                          selleSId: sellerSid,
                        );
                        uploadProvider.clearAll();
                      },
                      child: Icon(
                        Icons.upload,
                        color: whiteColor,
                      ),
                    )
                  : SizedBox()
            ],
          );
        }),
      ),
    );
  }
}

Widget displayMultipleImages(context, SellerProductsUploadController provider) {
  return Container(
    height: customHeightWidth(context, height: true) * 0.3,
    width: customHeightWidth(context, width: true) * 0.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: whiteColor,
    ),
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.multipleImagesList!.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Stack(
              children: [
                AnimatedContainer(
                  curve: Curves.easeInOutCubic,
                  margin: EdgeInsets.all(10),
                  duration: Duration(milliseconds: 500),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.file(
                      File(provider.multipleImagesList![index].path),
                      fit: BoxFit.fill,
                      height: customHeightWidth(context, height: true) * 0.3,
                      width: customHeightWidth(context, width: true) * 0.5,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Positioned(
                  left: 160,
                  top: 20,
                  child: GestureDetector(
                    onTap: () {
                      provider.clearMultipleImageList();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: whiteColor.withOpacity(0.5)),
                      child: Center(
                        child: CustomIconButtonComponet(
                          icon: Icons.clear,
                          iconColor: redColor,
                          iconSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
  );
}
