import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/models/productdata_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/home/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductCardComponent extends StatelessWidget {
  final int? productDataLength;
  final int? gridProductRow;
  final double? gridAspectRatio;
  final double? screenWidth;
  final Axis? scrollDirection;
  final AsyncSnapshot<QuerySnapshot>? snapshot;
  ProductCardComponent(
      {this.productDataLength,
      this.gridAspectRatio,
      this.gridProductRow,
      this.screenWidth,
      this.snapshot,
      this.scrollDirection = Axis.vertical});
  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 0;
    final double calcHeight =
        ((screenWidth! / gridProductRow!) - (horizontalPadding)) *
            (productDataLength! / gridProductRow!).ceil() *
            (1 / gridAspectRatio!);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: calcHeight,
        width: screenWidth!,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: gridAspectRatio!,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          scrollDirection: scrollDirection!,
          itemCount: productDataLength!,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot<Object?> productDataObject =
                snapshot!.data!.docs[index];
            Map<String, dynamic> productData =
                productDataObject.data() as Map<String, dynamic>;
            final productDataModelClass =
                ProductDataModelClass.fromMap(productData);
            int discountPrice = int.parse(productDataModelClass.productPrice!) -
                int.parse(productDataModelClass.productDiscount!);

            return GestureDetector(
              onTap: () {
                navigationPush(context,
                    screenWidget: ProductDetailsScreen(
                        productData: productDataModelClass));
              },
              child: Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(20.0),
                        // // boxShadow: [
                        // //   BoxShadow(
                        // //     color: Colors.grey.withOpacity(0.5),
                        // //     spreadRadius: 5,
                        // //     blurRadius: 10,
                        // //     offset: Offset(0, 3), // changes position of shadow
                        // //   ),
                        // ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Product Image
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  minHeight: 100, maxHeight: 250),
                              child: CachedNetworkImage(
                                  imageUrl: productDataModelClass
                                      .productImageFile![0],
                                  color: Colors.black.withOpacity(0.2),
                                  colorBlendMode: BlendMode.darken,
                                  height: 200,
                                  width: 250,
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
                          //Product Name
                          CustomTextComponet(
                            textTitle: productDataModelClass.productName!,
                            isCenterText: true,
                            isClickAble: false,
                            fontWeight: regularFontWeight,
                            fontSize: regularTextSize,
                            textPadding: EdgeInsets.all(4),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextComponet(
                                  textTitle:
                                      productDataModelClass.productDiscount ==
                                              "0"
                                          ? "Regular Price:"
                                          : "Discount Price:",
                                  isCenterText: false,
                                  isClickAble: false,
                                  fontWeight: regularBoldFontWeight,
                                  fontSize: smallTextSize,
                                  textPadding: EdgeInsets.all(0),
                                  fontColor:
                                      productDataModelClass.productDiscount ==
                                              "0"
                                          ? blackColor.withOpacity(0.8)
                                          : redColor.shade900,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextComponet(
                                          textTitle:
                                              "\$${productDataModelClass.productPrice}",
                                          isCenterText: false,
                                          isClickAble: false,
                                          fontWeight: regularFontWeight,
                                          fontSize: regularTextSize,
                                          textPadding: EdgeInsets.all(0),
                                          textDecoration: productDataModelClass
                                                      .productDiscount ==
                                                  "0"
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough,
                                          fontColor:
                                              blackColor.withOpacity(0.8),
                                        ),
                                        productDataModelClass.productDiscount !=
                                                "0"
                                            ? CustomTextComponet(
                                                textTitle: "\$$discountPrice",
                                                isCenterText: false,
                                                isClickAble: false,
                                                fontWeight: regularFontWeight,
                                                fontSize: regularTextSize,
                                                textPadding:
                                                    EdgeInsets.all(0.0),
                                                fontColor: redColor.shade500,
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    CustomIconButtonComponet(
                                      icon: Icons.favorite_outline,
                                      iconColor: redColor,
                                      iconSize: mediumIconSize,
                                      iconPadding: EdgeInsets.all(0.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  productDataModelClass.productNew!
                      ? Positioned(
                          child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CustomTextComponet(
                            textTitle: "New",
                            isCenterText: true,
                            fontSize: mediumTextSize,
                            fontColor: whiteColor,
                          ),
                        ))
                      : Container()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
