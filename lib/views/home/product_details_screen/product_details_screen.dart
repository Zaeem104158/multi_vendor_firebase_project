import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/custom_divider.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/product_card_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/models/productdata_view_model.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/provider/cart_provider/cart_provider.dart';
import 'package:firebase_multi_vendor_project/views/cart/cart_screen.dart';
import 'package:firebase_multi_vendor_project/views/home/full_product_image/full_image_screen.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_multi_vendor_project/views/provider/wishlist_provider/wishlist_provider.dart';
import 'package:firebase_multi_vendor_project/views/store/visit_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final UiProvider uiProvider =
        Provider.of<UiProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: blueGreyColor.shade100.withOpacity(0.5),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  //? Image SLider
                  SizedBox(
                    width: 400,
                    height: 250,
                    child: PageView.builder(
                        clipBehavior: Clip.none,
                        controller: uiProvider.pageController,
                        onPageChanged: (page) {
                          uiProvider.updatePageControllerSelectedValue(page);
                        },
                        itemCount:
                            uiProvider.productData!.productImageFile!.length,
                        pageSnapping: true,
                        itemBuilder: (context, pagePosition) {
                          bool active = pagePosition ==
                              uiProvider.pageControlSelectedIndex;
                          double margin = active ? 10 : 20;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              curve: Curves.easeInOutCubic,
                              margin: EdgeInsets.all(margin),
                              duration: Duration(milliseconds: 500),
                              child: GestureDetector(
                                onTap: () {
                                  navigationPush(context,
                                      screenWidget: FullImageScreen(
                                          // imageFileList: uiProvider
                                          //     .productData!.productImageFile!,
                                          // activeImage: activePage,
                                          ));
                                },
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  child: CachedNetworkImage(
                                      imageUrl: uiProvider.productData!
                                          .productImageFile![pagePosition],
                                      color: Colors.black.withOpacity(0.2),
                                      colorBlendMode: BlendMode.darken,
                                      height: 100,
                                      width: 100,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          SizedBox(
                                              //height: 80,
                                              child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress,
                                                  color: redColor
                                                      .withOpacity(0.3)),
                                            ),
                                          )),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  //? Image Slider Indicator
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: indicators(
                          uiProvider.productData!.productImageFile!.length,
                          uiProvider.pageControlSelectedIndex)),
                  //? Product Price, favorite icon, instock, descritpion
                  Column(children: [
                    CustomDivider(
                      mainAxisAlignment: MainAxisAlignment.center,
                      isCenter: true,
                      withTextDivider: true,
                      onlyDivider: false,
                      text: AppLocalizations.of(context)!.product_description,
                      thickness: 1,
                      color: greyColor,
                      textPadding: EdgeInsets.all(16),
                      fontColor: blackColor.withOpacity(0.8),
                      fontSize: regularTextSize,
                    ),
                    CustomTextComponet(
                      textTitle: uiProvider.productData!.productName,
                      fontWeight: regularBoldFontWeight,
                      fontColor: greyColor,
                      isCenterText: true,
                      isClickAble: false,
                      fontSize: largeTextSize,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextComponet(
                            textTitle:
                                "${AppLocalizations.of(context)!.tk_title}${uiProvider.productData!.productPrice}",
                            fontWeight: regularBoldFontWeight,
                            fontColor: greyColor,
                            isCenterText: true,
                            isClickAble: false,
                            fontSize: mediumTextSize,
                            textPadding: EdgeInsets.all(24),
                          ),
                          CustomIconButtonComponet(
                            icon: context
                                        .watch<WishListProvider>()
                                        .getWishItems
                                        .firstWhereOrNull((wish) =>
                                            wish.productId ==
                                            uiProvider
                                                .productData!.productId) !=
                                    null
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            iconColor: redColor,
                            iconSize: mediumIconSize,
                            iconPadding: EdgeInsets.zero,
                            onPressed: () {
                              bool hasProduct = false;
                              Provider.of<WishListProvider>(context,
                                      listen: false)
                                  .getWishItems
                                  .forEach((element) {
                                element.productId ==
                                        uiProvider.productData!.productId
                                    ? hasProduct = true
                                    : hashCode;
                              });
                              hasProduct
                                  ? context
                                      .read<WishListProvider>()
                                      .removeFromWish(
                                          uiProvider.productData!.productId!)
                                  // ! Provider.of<WishlistProvuder>(context,listen: false).removeFromWish(uiProvider.productData!.productId!) and above read context are same
                                  //  ! Provider.of<WishlistProvuder>(context,listen: true).removeFromWish(uiProvider.productData!.productId!) and  context.watch<WishlistProvider>().removeFromWish(uiProvider.productData!.productId!)  are same thing
                                  : Provider.of<WishListProvider>(context,
                                          listen: false)
                                      .addWishItem(context,
                                          productData: ProductDataViewModel(
                                            selectQuantity: 1,
                                            mainCategory: uiProvider
                                                .productData!.mainCategory,
                                            subCategory: uiProvider
                                                .productData!.subCategory,
                                            productDescription: uiProvider
                                                .productData!
                                                .productDescription,
                                            productName: uiProvider
                                                .productData!.productName,
                                            productPrice: uiProvider
                                                .productData!.productPrice,
                                            productDiscount: uiProvider
                                                .productData!.productDiscount,
                                            productSid: uiProvider
                                                .productData!.productSid,
                                            productId: uiProvider
                                                .productData!.productId,
                                            productInstock: uiProvider
                                                .productData!.productInstock,
                                            productImageFile: uiProvider
                                                .productData!.productImageFile,
                                          ));
                            },
                          ),
                        ]),
                    Container(
                      width: customHeightWidth(context, width: true) * 0.8,
                      decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: CustomTextComponet(
                        textTitle:
                            "${uiProvider.productData!.productInstock} ${AppLocalizations.of(context)!.products_in_stock}",
                        fontWeight: regularBoldFontWeight,
                        fontColor: whiteColor,
                        isCenterText: true,
                        isClickAble: false,
                        fontSize: mediumTextSize,
                        textOverflow: TextOverflow.visible,
                        textPadding: EdgeInsets.all(16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: blackColor.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0)),
                        ),
                        child: CustomTextComponet(
                          textTitle:
                              "${AppLocalizations.of(context)!.details} ${uiProvider.productData!.productDescription}",
                          fontWeight: regularBoldFontWeight,
                          maxLine: 10,
                          fontColor: whiteColor,
                          isCenterText: false,
                          isClickAble: false,
                          fontSize: mediumTextSize,
                          textOverflow: TextOverflow.visible,
                          textPadding: EdgeInsets.all(24),
                        ),
                      ),
                    )
                  ]),
                  //? Divider
                  CustomDivider(
                    mainAxisAlignment: MainAxisAlignment.center,
                    isCenter: true,
                    withTextDivider: true,
                    onlyDivider: false,
                    text: AppLocalizations.of(context)!.similar_products,
                    thickness: 1,
                    color: greyColor,
                    textPadding: EdgeInsets.all(0),
                    fontColor: blackColor.withOpacity(0.8),
                    fontSize: mediumTextSize,
                  ),
                  //? Similler Products
                  similerProduct(
                      maincategory: uiProvider.productData!.mainCategory,
                      subCategory: uiProvider.productData!.subCategory,
                      width: width),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            child: CustomIconButtonComponet(
              icon: Icons.arrow_back_ios_new,
              iconColor: blackColor,
              onPressed: () {
                navigationPop(context);
              },
            ),
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButtonComponet(
            icon: Icons.store,
            iconColor: blackColor,
            iconSize: mediumIconSize,
            iconPadding: EdgeInsets.all(2),
            onPressed: () {
              navigationPush(context,
                  screenWidget: VisitStoreScreen(
                    sellerId: uiProvider.productData!.productSid,
                  ));
            },
          ),
          Stack(
            children: [
              CustomIconButtonComponet(
                icon: Icons.shopping_cart,
                iconColor: blackColor,
                iconSize: mediumIconSize,
                iconPadding: EdgeInsets.all(2),
                onPressed: () {
                  navigationPush(context, screenWidget: CartScreen());
                },
              ),
              Provider.of<CartProvider>(context, listen: true)
                          .getItems
                          .length !=
                      0
                  ? Positioned(
                      left: 30,
                      child: Container(
                          //margin: EdgeInsets.all(3),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: redColor,
                            shape: BoxShape.circle,
                          ),
                          child: CustomTextComponet(
                            textTitle:
                                "${Provider.of<CartProvider>(context).getItems.length}",
                            isCenterText: true,
                            fontSize: smallerTextSize,
                            fontColor: whiteColor,
                            fontWeight: regularBoldFontWeight,
                          )),
                    )
                  : SizedBox()
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: customHeightWidth(context, height: true) / 20,
              width: customHeightWidth(context, width: true) * 0.4,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cyanColor,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: GestureDetector(
                  onTap: () {
                    bool hasProduct = false;
                    Provider.of<CartProvider>(context, listen: false)
                        .getItems
                        .forEach((element) {
                      element.productId == uiProvider.productData!.productId
                          ? hasProduct = true
                          : hashCode;
                    });
                    hasProduct
                        ? showSnack(context,
                            AppLocalizations.of(context)!.already_product_added)
                        : Provider.of<CartProvider>(context, listen: false)
                            .addItem(
                                context,
                                productData: ProductDataViewModel(
                                    selectQuantity: 1,
                                    mainCategory: uiProvider
                                        .productData!.mainCategory,
                                    subCategory: uiProvider
                                        .productData!.subCategory,
                                    productDescription: uiProvider
                                        .productData!.productDescription,
                                    productName: uiProvider
                                        .productData!.productName,
                                    productPrice:
                                        uiProvider.productData!.productPrice,
                                    productDiscount:
                                        uiProvider.productData!.productDiscount,
                                    productSid:
                                        uiProvider.productData!.productSid,
                                    productId:
                                        uiProvider.productData!.productId,
                                    productInstock:
                                        uiProvider.productData!.productInstock,
                                    productImageFile: uiProvider
                                        .productData!.productImageFile));
                  },
                  child: CustomTextComponet(
                    isCenterText: true,
                    isClickAble: true,
                    textTitle: AppLocalizations.of(context)!.add_to_cart,
                    fontColor: whiteColor,
                    fontSize: regularTextSize,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

Widget similerProduct(
    {String? maincategory, String? subCategory, double? width}) {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection(productsDataDirectory)
      .where(productCollectionFieldMainCategory, isEqualTo: maincategory)
      .where(productCollectionFieldSubCategory, isEqualTo: subCategory)
      .snapshots();
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

      return ProductCardComponent(
        productDataLength: snapshot.data!.docs.length,
        gridProductRow: 2,
        gridAspectRatio: 0.55,
        screenWidth: width,
        snapshot: snapshot,
        scrollDirection: Axis.vertical,
      );
    },
  );
}
