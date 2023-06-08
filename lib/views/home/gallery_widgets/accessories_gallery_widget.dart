import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/models/productdata_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class AccessoriesGalleryWidget extends StatefulWidget {
  const AccessoriesGalleryWidget({super.key});

  @override
  State<AccessoriesGalleryWidget> createState() =>
      _AccessoriesGalleryWidgetWidgetState();
}

class _AccessoriesGalleryWidgetWidgetState
    extends State<AccessoriesGalleryWidget> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection(productsDataDirectory)
      .where(productCollectionFieldMainCategory, isEqualTo: 'Accessories')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: cyanColor,
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return CustomTextComponet(
            textTitle: "This category\nhas not data yet.",
            fontSize: largeTextSize,
            fontWeight: regularBoldFontWeight,
            fontColor: redColor.withOpacity(0.5),
            isCenterText: true,
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 0.65,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot<Object?> productDataObject =
                snapshot.data!.docs[index];
            Map<String, dynamic> productData =
                productDataObject.data() as Map<String, dynamic>;
            final productDataModelClass =
                ProductDataModelClass.fromMap(productData);
            int discountPrice = int.parse(productDataModelClass.productPrice!) -
                int.parse(productDataModelClass.productDiscount!);
            return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(minHeight: 100, maxHeight: 250),
                        child: CachedNetworkImage(
                            imageUrl:
                                productDataModelClass.productImageFile![0],
                            color: Colors.black.withOpacity(0.2),
                            colorBlendMode: BlendMode.darken,
                            height: 200,
                            width: 250,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
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
                        // Image.network(
                        //   productDataModelClass.productImageFile![0],
                        //   fit: BoxFit.fill,
                        //   height: 200,
                        //   width: 250,
                        // ),
                      ),
                    ),
                    CustomTextComponet(
                      textTitle: productDataModelClass.productName!,
                      isCenterText: true,
                      isClickAble: false,
                      fontWeight: regularFontWeight,
                      fontSize: regularTextSize,
                      textPadding: EdgeInsets.all(2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        productDataModelClass.productDiscount! != "0"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextComponet(
                                    textTitle: "Regular Price:",
                                    isCenterText: true,
                                    isClickAble: false,
                                    fontWeight: regularFontWeight,
                                    fontSize: smallTextSize,
                                    textPadding: EdgeInsets.zero,
                                    fontColor: blackColor.withOpacity(0.8),
                                  ),
                                  CustomTextComponet(
                                    textTitle:
                                        "\$${productDataModelClass.productPrice}",
                                    isCenterText: false,
                                    isClickAble: false,
                                    fontWeight: regularFontWeight,
                                    fontSize: regularTextSize,
                                    textPadding: EdgeInsets.zero,
                                    textDecoration: TextDecoration.lineThrough,
                                    fontColor: blackColor.withOpacity(0.8),
                                  ),
                                  CustomTextComponet(
                                    textTitle: "Discount Price:",
                                    isCenterText: false,
                                    isClickAble: false,
                                    fontWeight: regularFontWeight,
                                    fontSize: smallTextSize,
                                    textPadding: EdgeInsets.zero,
                                    fontColor: redColor.shade800,
                                  ),
                                  CustomTextComponet(
                                    textTitle: "\$$discountPrice",
                                    isCenterText: false,
                                    isClickAble: false,
                                    fontWeight: regularFontWeight,
                                    fontSize: regularTextSize,
                                    textPadding: EdgeInsets.zero,
                                    fontColor: redColor.shade800,
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextComponet(
                                    textTitle: "Regular Price:",
                                    isCenterText: true,
                                    isClickAble: false,
                                    fontWeight: regularFontWeight,
                                    fontSize: smallTextSize,
                                    textPadding: EdgeInsets.zero,
                                    fontColor: blackColor.withOpacity(0.8),
                                  ),
                                  CustomTextComponet(
                                    textTitle:
                                        "\$${productDataModelClass.productPrice}",
                                    isCenterText: false,
                                    isClickAble: false,
                                    fontWeight: regularFontWeight,
                                    fontSize: regularTextSize,
                                    textPadding: EdgeInsets.zero,
                                    textDecoration: TextDecoration.none,
                                    fontColor: blackColor.withOpacity(0.8),
                                  ),
                                ],
                              ),
                        CustomIconButtonComponet(
                          icon: Icons.favorite_outline,
                          iconColor: redColor,
                          iconSize: mediumIconSize,
                          iconPadding: EdgeInsets.zero,
                        )
                      ],
                    )
                  ],
                ));
          },
        );
      },
    );
  }
}
