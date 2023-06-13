import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_multi_vendor_project/components/custom_box_container.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/home/product_checkout/checkout_screen.dart';
import 'package:firebase_multi_vendor_project/views/provider/cart_provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 0.0,
        title: CustomTextComponet(
          isCenterText: true,
          textTitle: 'Cart',
          fontSize: appBarTitleTextSize,
          fontWeight: regularBoldFontWeight,
          textPadding: EdgeInsets.only(left: 24.0),
        ),
        actions: [
          CustomIconButtonComponet(
            icon: Icons.delete_forever,
            iconColor: blackColor,
            iconSize: mediumIconSize,
            onPressed: () {
              context.read<CartProvider>().clearItem();
            },
          )
        ],
      ),
      body: context.watch<CartProvider>().getItems.isNotEmpty
          ? Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return ListView.builder(
                  itemCount: cartProvider.getCount,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 120,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: CachedNetworkImage(
                                  imageUrl: cartProvider
                                      .getItems[index].productImageFile![0],
                                  color: Colors.black.withOpacity(0.2),
                                  colorBlendMode: BlendMode.darken,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      SizedBox(
                                          //height: 80,
                                          child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              color: redColor.withOpacity(0.3)),
                                        ),
                                      )),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomTextComponet(
                                    textTitle: cartProvider
                                        .getItems[index].productName,
                                    maxLine: 2,
                                    fontColor: blackColor,
                                    fontWeight: regularBoldFontWeight,
                                    fontSize: mediumTextSize,
                                    isCenterText: false,
                                    textPadding: EdgeInsets.all(2),
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomTextComponet(
                                        textTitle: cartProvider.getItems[index]
                                                    .productDiscount ==
                                                "0"
                                            ? "\$${cartProvider.getItems[index].productPrice}"
                                            : "\$${int.parse(cartProvider.getItems[index].productPrice!) - int.parse(cartProvider.getItems[index].productDiscount!)}",
                                        maxLine: 1,
                                        fontColor: cyanColor,
                                        fontWeight: regularBoldFontWeight,
                                        fontSize: regularTextSize,
                                        isCenterText: false,
                                        textPadding: EdgeInsets.all(2),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: greyColor.shade200,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Row(children: [
                                          CustomIconButtonComponet(
                                            icon: Icons.add,
                                            iconSize: 20,
                                            iconColor: cartProvider
                                                        .getItems[index]
                                                        .productInstock ==
                                                    cartProvider.getItems[index]
                                                        .selectQuantity
                                                        .toString()
                                                ? greyColor
                                                : blackColor,
                                            onPressed: () {
                                              int inStock = int.parse(
                                                  cartProvider.getItems[index]
                                                      .productInstock!);

                                              inStock >
                                                      cartProvider
                                                          .getItems[index]
                                                          .selectQuantity
                                                  ? cartProvider
                                                      .increaseProduct(
                                                          cartProvider
                                                              .getItems[index])
                                                  : null;
                                            },
                                          ),
                                          Text(cartProvider
                                              .getItems[index].selectQuantity
                                              .toString()),
                                          CustomIconButtonComponet(
                                            icon: Icons.remove,
                                            iconSize: 20,
                                            iconColor: cartProvider
                                                        .getItems[index]
                                                        .selectQuantity ==
                                                    1
                                                ? greyColor
                                                : blackColor,
                                            onPressed: cartProvider
                                                        .getItems[index]
                                                        .selectQuantity ==
                                                    1
                                                ? null
                                                : () {
                                                    cartProvider
                                                        .decreaseProduct(
                                                            cartProvider
                                                                    .getItems[
                                                                index]);
                                                  },
                                          ),
                                        ]),
                                      )
                                    ],
                                  ),
                                  CustomTextComponet(
                                    textTitle:
                                        "InStock:${cartProvider.recentInStock(cartProvider.getItems[index])}",
                                    maxLine: 1,
                                    fontColor: greyColor,
                                    fontWeight: regularBoldFontWeight,
                                    fontSize: regularTextSize,
                                    isCenterText: false,
                                    textPadding: EdgeInsets.all(2),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextComponet(
                  textTitle: "Your Cart is Empty",
                  fontSize: largeTextSize,
                ),
                CustomSizedBox(
                  height: customHeightWidth(context, height: true) / 15,
                ),
                Center(
                  child: CustomBoxContainer(
                    height: customHeightWidth(context, height: true) / 20,
                    width: customHeightWidth(context, width: true) * 0.5,
                    color: greyColor,
                    borderRadius: BorderRadius.circular(15.0),
                    child: GestureDetector(
                        onTap: () {},
                        child: CustomTextComponet(
                          isCenterText: true,
                          isClickAble: true,
                          textTitle: "continue shopping",
                          fontColor: whiteColor,
                          fontSize: regularTextSize,
                        )),
                  ),
                )
              ],
            ),
      bottomSheet:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            CustomTextComponet(
              isCenterText: false,
              isClickAble: false,
              textPadding: EdgeInsets.all(4),
              textTitle: "Total:\$",
            ),
            CustomTextComponet(
              isCenterText: false,
              isClickAble: false,
              textPadding: EdgeInsets.all(0),
              textTitle:
                  "${Provider.of<CartProvider>(context, listen: true).totalPrice.toStringAsFixed(2)}",
              fontColor: redColor,
              fontWeight: regularBoldFontWeight,
            ),
          ],
        ),
        GestureDetector(
          onTap: Provider.of<CartProvider>(context, listen: false).totalPrice !=
                  0.00
              ? () {
                  navigationPush(context,
                      screenWidget: ProductCheckOutScreen());
                }
              : null,
          child: Container(
            height: customHeightWidth(context, height: true) / 20,
            width: customHeightWidth(context, width: true) * 0.4,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Provider.of<CartProvider>(context, listen: false)
                          .totalPrice !=
                      0.00
                  ? blackColor
                  : greyColor,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: CustomTextComponet(
              isCenterText: true,
              isClickAble: true,
              textTitle: "CHECKOUT",
              fontColor: whiteColor,
              fontSize: regularTextSize,
            ),
          ),
        ),
      ]),
    );
  }
}
