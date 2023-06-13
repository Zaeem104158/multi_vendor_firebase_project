import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_multi_vendor_project/components/custom_box_container.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/provider/wishlist_provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

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
              context.read<WishListProvider>().clearWishItem();
            },
          )
        ],
      ),
      body: context.watch<WishListProvider>().getWishItems.isNotEmpty
          ? Consumer<WishListProvider>(
              builder: (context, wishProvider, child) {
                return ListView.builder(
                  itemCount: wishProvider.getWishCount,
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
                                  imageUrl: wishProvider
                                      .getWishItems[index].productImageFile![0],
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
                                    textTitle: wishProvider
                                        .getWishItems[index].productName,
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
                                        textTitle: wishProvider
                                                    .getWishItems[index]
                                                    .productDiscount ==
                                                "0"
                                            ? "\$${wishProvider.getWishItems[index].productPrice}"
                                            : "\$${int.parse(wishProvider.getWishItems[index].productPrice!) - int.parse(wishProvider.getWishItems[index].productDiscount!)}",
                                        maxLine: 1,
                                        fontColor: cyanColor,
                                        fontWeight: regularBoldFontWeight,
                                        fontSize: regularTextSize,
                                        isCenterText: false,
                                        textPadding: EdgeInsets.all(2),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<WishListProvider>()
                                              .removeWishItem(wishProvider
                                                  .getWishItems[index]);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: greyColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.0),
                                                  bottomLeft:
                                                      Radius.circular(20.0))),
                                          child: Center(
                                            child: CustomIconButtonComponet(
                                              icon: Icons.backspace,
                                              iconColor: blackColor,
                                              iconSize: smallIconSize,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
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
                  textTitle: "Your Wishlist is Empty",
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
