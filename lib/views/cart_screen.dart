import 'package:firebase_multi_vendor_project/components/custom_box_container.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

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
          )
        ],
      ),
      bottomSheet: Row(children: [
        CustomTextComponet(
          isCenterText: false,
          isClickAble: false,
          textPadding: EdgeInsets.all(4),
          textTitle: "Total:\$",
        ),
        CustomTextComponet(
          isCenterText: false,
          isClickAble: false,
          textPadding: EdgeInsets.all(4),
          textTitle: "0.0",
          fontColor: redColor,
          fontWeight: regularBoldFontWeight,
        ),
        CustomSizedBox(
          width: customHeightWidth(context, width: true) * 0.20,
        ),
        CustomBoxContainer(
          height: customHeightWidth(context, height: true) / 20,
          width: customHeightWidth(context, width: true) * 0.4,
          color: blackColor,
          padding: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(50.0),
          child: GestureDetector(
              onTap: () {},
              child: CustomTextComponet(
                isCenterText: true,
                isClickAble: true,
                textTitle: "CHECKOUT",
                fontColor: whiteColor,
                fontSize: regularTextSize,
              )),
        ),
      ]),
      body: Column(
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
    );
  }
}
