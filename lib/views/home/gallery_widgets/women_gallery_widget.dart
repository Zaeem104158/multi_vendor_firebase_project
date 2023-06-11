import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/product_card_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class WomenGalleryWidget extends StatefulWidget {
  const WomenGalleryWidget({super.key});

  @override
  State<WomenGalleryWidget> createState() => _WomenGalleryWidgetState();
}

class _WomenGalleryWidgetState extends State<WomenGalleryWidget> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection(productsDataDirectory)
      .where(productCollectionFieldMainCategory, isEqualTo: 'Women')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
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
          return Container(
            constraints: BoxConstraints(
              maxHeight: customHeightWidth(context, height: true) / 5,
              minWidth: customHeightWidth(context, width: true) / 3,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: whiteColor),
            child: CustomTextComponet(
              textTitle: "This category\nhas not data yet.",
              fontSize: largeTextSize,
              fontWeight: regularBoldFontWeight,
              fontColor: redColor.withOpacity(0.5),
              isCenterText: true,
            ),
          );
        }

        return ProductCardComponent(
          productDataLength: snapshot.data!.docs.length,
          gridProductRow: 2,
          gridAspectRatio: 0.55,
          screenWidth: width,
          snapshot: snapshot,
        );
      },
    );
  }
}
