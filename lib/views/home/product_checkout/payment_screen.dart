import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/models/productdata_view_model.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/provider/cart_provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          textTitle: "Place Order",
          fontColor: blackColor,
          fontSize: regularTextSize,
          fontWeight: regularFontWeight,
          isCenterText: true,
        ),
      ),
      body: Container(
        child: CustomTextComponet(
          textTitle:
              "${context.watch<CartProvider>().getOrderItems.map((e) => e.productName).toList()}",
          fontColor: blackColor,
          fontSize: regularTextSize,
          fontWeight: regularFontWeight,
          isCenterText: true,
        ),
      ),
    );
  }
}
