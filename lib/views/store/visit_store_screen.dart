import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/product_card_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class VisitStoreScreen extends StatelessWidget {
  final String? sellerId;
  VisitStoreScreen({this.sellerId});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    String? sellerPhoneNumber;
    return Scaffold(
      backgroundColor: blueGreyColor.shade100.withOpacity(0.5),
      appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: customHeightWidth(context, height: true) / 8,
          elevation: 0.0,
          backgroundColor: greyColor,
          leading: CustomIconButtonComponet(
            icon: Icons.arrow_back_ios_new,
            iconColor: blackColor,
            onPressed: () {
              navigationPop(context);
            },
          ),
          title: FutureBuilder(
            future: _firebaseFirestore
                .collection("sellers")
                .where('sid', isEqualTo: sellerId)
                .get(),
            builder: (context, snapshot) {
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
              sellerPhoneNumber =
                  "+880${snapshot.data!.docs[0]["phoneNumber"]}";
              return CustomTextComponet(
                textTitle: snapshot.data!.docs[0]["fullName"],
                isCenterText: true,
                fontWeight: regularBoldFontWeight,
                fontSize: largeTextSize,
              );
            },
          )),
      body: FutureBuilder(
        future: _firebaseFirestore
            .collection('productsData')
            .where(sellerCollectionFieldSid, isEqualTo: sellerId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomTextComponet(
              textTitle: "Something Went wrong",
              isClickAble: false,
              isCenterText: true,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show a loading indicator
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            // Handle the case when the snapshot has zero data
            return CustomTextComponet(
              textTitle: "This store\n\nhasn't any product yet",
              isClickAble: false,
              isCenterText: true,
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ProductCardComponent(
              productDataLength: snapshot.data!.docs.length,
              gridProductRow: 2,
              gridAspectRatio: 0.48,
              screenWidth: customHeightWidth(context, width: true),
              snapshot: snapshot,
            );
          }
          return Container();
        },
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: greyColor),
        child: CustomIconButtonComponet(
          icon: Icons.chat,
          iconColor: redColor,
          iconSize: 30,
          onPressed: () async {
            //Do work
            log("Pressed");
            sendWhatsAppMessage(sellerPhoneNumber!, "Hello....");
          },
        ),
      ),
    );
  }
}
