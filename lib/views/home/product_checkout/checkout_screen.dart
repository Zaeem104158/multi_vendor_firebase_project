import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/models/productdata_view_model.dart';
import 'package:firebase_multi_vendor_project/models/userInfo_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/home/product_checkout/payment_screen.dart';
import 'package:firebase_multi_vendor_project/views/provider/cart_provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCheckOutScreen extends StatelessWidget {
  ProductCheckOutScreen({super.key});
  final AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return FutureBuilder(
        future: authController.userCustomerInfo(),
        builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return CustomTextComponet(
              textTitle: "Something Went wrong",
              isClickAble: false,
              isCenterText: true,
            );
          } else if (snapshot.hasData && !snapshot.data!.exists) {
            return CustomTextComponet(
              isCenterText: true,
              textTitle: "Document doesn't exist",
              isClickAble: false,
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final profileData = UserInfoModelClass.fromMap(data);
            dismissLoading();
            return Scaffold(
              backgroundColor: greyColor.shade200,
              appBar: AppBar(
                backgroundColor: greyColor.shade200,
                elevation: 0.0,
                leading: CustomIconButtonComponet(
                  icon: Icons.arrow_back_ios_new,
                  iconColor: blackColor,
                  onPressed: () {
                    navigationPop(context);
                  },
                ),
                title: CustomTextComponet(
                  textTitle: "CheckOut",
                  fontColor: blackColor,
                  fontSize: regularTextSize,
                  fontWeight: regularFontWeight,
                  isCenterText: true,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextComponet(
                              textTitle: "Name: ${profileData.fullName}",
                              isCenterText: false,
                              isClickAble: false,
                              fontColor: blackColor,
                              fontSize: smallTextSize,
                              fontWeight: regularFontWeight,
                            ),
                            CustomTextComponet(
                              textTitle: "Address: ${profileData.address}",
                              maxLine: 3,
                              isCenterText: false,
                              isClickAble: false,
                              fontColor: blackColor,
                              fontSize: smallTextSize,
                              fontWeight: regularFontWeight,
                            ),
                            CustomTextComponet(
                              textTitle: "Phone: ${profileData.phoneNumber}",
                              isCenterText: false,
                              isClickAble: false,
                              fontColor: blackColor,
                              fontSize: smallTextSize,
                              fontWeight: regularFontWeight,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Consumer<CartProvider>(
                              builder: (context, cartProvider, child) {
                            return ListView.builder(
                              itemCount: context.watch<CartProvider>().getCount,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          width: 120,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            child: CachedNetworkImage(
                                                imageUrl: context
                                                    .read<CartProvider>()
                                                    .getItems[index]
                                                    .productImageFile![0],
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                colorBlendMode:
                                                    BlendMode.darken,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        SizedBox(
                                                            //height: 80,
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Center(
                                                            child: CircularProgressIndicator(
                                                                value:
                                                                    downloadProgress
                                                                        .progress,
                                                                color: redColor
                                                                    .withOpacity(
                                                                        0.3)),
                                                          ),
                                                        )),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                CustomTextComponet(
                                                  textTitle: context
                                                      .read<CartProvider>()
                                                      .getItems[index]
                                                      .productName,
                                                  maxLine: 2,
                                                  fontColor: blackColor,
                                                  fontWeight:
                                                      regularBoldFontWeight,
                                                  fontSize: mediumTextSize,
                                                  isCenterText: false,
                                                  textPadding:
                                                      EdgeInsets.all(2),
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        CustomTextComponet(
                                                          textTitle:
                                                              "Total Price:\$${context.read<CartProvider>().getItems[index].selectQuantity * (int.parse(context.read<CartProvider>().getItems[index].productPrice!) - int.parse(context.read<CartProvider>().getItems[index].productDiscount!))}",
                                                          maxLine: 1,
                                                          fontColor: cyanColor,
                                                          fontWeight:
                                                              regularBoldFontWeight,
                                                          fontSize:
                                                              smallerTextSize,
                                                          isCenterText: false,
                                                          textPadding:
                                                              EdgeInsets.all(2),
                                                        ),
                                                        CustomTextComponet(
                                                          textTitle:
                                                              "Total Item: ${context.read<CartProvider>().getItems[index].selectQuantity}",
                                                          maxLine: 1,
                                                          fontColor: cyanColor,
                                                          fontWeight:
                                                              regularBoldFontWeight,
                                                          fontSize:
                                                              smallerTextSize,
                                                          isCenterText: false,
                                                          textPadding:
                                                              EdgeInsets.all(2),
                                                        ),
                                                      ],
                                                    ),
                                                    CustomIconButtonComponet(
                                                      icon: cartProvider
                                                              .getItems[index]
                                                              .isSelected
                                                          ? Icons
                                                              .radio_button_on
                                                          : Icons
                                                              .radio_button_off,
                                                      onPressed: () {
                                                        if (cartProvider
                                                            .getItems[index]
                                                            .isSelected) {
                                                          cartProvider
                                                              .deselectItem(
                                                                  cartProvider
                                                                      .getItems[
                                                                          index]
                                                                      .productId!);
                                                          //Here
                                                          cart.getOrderItems
                                                              .remove(cartProvider
                                                                      .getItems[
                                                                  index]);
                                                        } else {
                                                          cartProvider.selectItem(
                                                              cartProvider
                                                                  .getItems[
                                                                      index]
                                                                  .productId!);
                                                          // Here
                                                          cart.setOrderItems([
                                                            cartProvider
                                                                .getItems[index]
                                                          ]);
                                                        }
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          })),
                    )
                  ],
                ),
              ),
              bottomSheet: GestureDetector(
                onTap: () {
                  // log("${context.read<CartProvider>().getOrderItems.map((e) => e.productName).toList()}");

                  navigationPush(context, screenWidget: PaymentScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        width: customHeightWidth(context, width: true) * 0.9,
                        decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: GestureDetector(
                          child: CustomTextComponet(
                            textTitle: "Confirm",
                            fontColor: whiteColor,
                            isCenterText: true,
                            isClickAble: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Material(
            child: Center(
                child: CircularProgressIndicator(
              color: cyanColor,
            )),
          );
        }));
  }
}
