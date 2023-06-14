import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/provider/cart_provider/cart_provider.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextComponet(
                          textTitle: "Total Price:",
                          isCenterText: false,
                          isClickAble: false,
                          fontColor: blackColor,
                          fontSize: regularTextSize,
                          fontWeight: regularFontWeight,
                        ),
                        CustomTextComponet(
                          textTitle:
                              "${context.read<CartProvider>().totalOrderPrice}",
                          isCenterText: false,
                          isClickAble: false,
                          fontColor: blackColor,
                          fontSize: regularTextSize,
                          fontWeight: regularFontWeight,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextComponet(
                          textTitle: "Shiping Charge:",
                          isCenterText: false,
                          isClickAble: false,
                          fontColor: blackColor,
                          fontSize: regularTextSize,
                          fontWeight: regularFontWeight,
                        ),
                        CustomTextComponet(
                          textTitle: "100.0",
                          isCenterText: false,
                          isClickAble: false,
                          fontColor: blackColor,
                          fontSize: regularTextSize,
                          fontWeight: regularFontWeight,
                        ),
                      ],
                    ),
                    Divider(
                      color: cyanColor,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextComponet(
                          textTitle: "In Total:",
                          isCenterText: false,
                          isClickAble: false,
                          fontColor: blackColor,
                          fontSize: regularTextSize,
                          fontWeight: regularFontWeight,
                        ),
                        CustomTextComponet(
                          textTitle:
                              "${context.read<CartProvider>().totalOrderPrice + 100}",
                          isCenterText: false,
                          isClickAble: false,
                          fontColor: blackColor,
                          fontSize: regularTextSize,
                          fontWeight: regularFontWeight,
                        ),
                      ],
                    ),
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Consumer<UiProvider>(
                    builder: (context, radioListTileProvider, child) {
                  return Column(
                    children: [
                      RadioListTile(
                        value: 1,
                        groupValue:
                            radioListTileProvider.radioTileSelectedValue,
                        onChanged: (value) {
                          radioListTileProvider
                              .updateRadioTileSelectedValue(value!);
                        },
                        title: CustomTextComponet(
                          textTitle: "Cash on Delivery",
                        ),
                        subtitle: CustomTextComponet(
                          textTitle: "Pay from home",
                        ),
                      ),
                      RadioListTile(
                        value: 2,
                        groupValue:
                            radioListTileProvider.radioTileSelectedValue,
                        onChanged: (value) {
                          radioListTileProvider
                              .updateRadioTileSelectedValue(value!);
                        },
                        title: CustomTextComponet(
                          textTitle: "Pay on Bkash",
                        ),
                      ),
                      RadioListTile(
                        value: 3,
                        groupValue:
                            radioListTileProvider.radioTileSelectedValue,
                        onChanged: (value) {
                          radioListTileProvider
                              .updateRadioTileSelectedValue(value!);
                        },
                        title: CustomTextComponet(
                          textTitle: "Pay on Card",
                        ),
                      ),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: GestureDetector(
                  child: CustomTextComponet(
                    textTitle:
                        "Pay ${context.read<CartProvider>().totalOrderPrice + 100}",
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
}
