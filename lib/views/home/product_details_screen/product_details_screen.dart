import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/custom_divider.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/product_card_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/models/productdata_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDataModelClass? productData;

  ProductDetailsScreen({super.key, this.productData});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late PageController _pageController;
  int activePage = 1;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7, initialPage: 1);
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: greyColor,
        automaticallyImplyLeading: true,
        title: CustomTextComponet(
          textTitle: "Product Details Screen",
          isCenterText: true,
          fontWeight: regularBoldFontWeight,
          fontColor: whiteColor,
          fontSize: mediumTextSize,
          isClickAble: false,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              width: 400,
              height: 250,
              child: PageView.builder(
                  clipBehavior: Clip.none,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  itemCount: widget.productData!.productImageFile!.length,
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    bool active = pagePosition == activePage;
                    double margin = active ? 10 : 20;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        curve: Curves.easeInOutCubic,
                        margin: EdgeInsets.all(margin),
                        duration: Duration(milliseconds: 500),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: CachedNetworkImage(
                              imageUrl: widget
                                  .productData!.productImageFile![pagePosition],
                              color: Colors.black.withOpacity(0.2),
                              colorBlendMode: BlendMode.darken,
                              height: 100,
                              width: 100,
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
                        ),
                      ),
                    );
                  }),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(
                    widget.productData!.productImageFile!.length, activePage)),
            Column(children: [
              CustomDivider(
                mainAxisAlignment: MainAxisAlignment.center,
                isCenter: true,
                withTextDivider: true,
                onlyDivider: false,
                text: "Product Description",
                thickness: 1,
                color: greyColor,
                textPadding: EdgeInsets.all(16),
                fontColor: blackColor.withOpacity(0.8),
                fontSize: mediumTextSize,
              ),
              CustomTextComponet(
                textTitle: widget.productData!.productName,
                fontWeight: regularBoldFontWeight,
                fontColor: greyColor,
                isCenterText: true,
                isClickAble: false,
                fontSize: largeTextSize,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                CustomTextComponet(
                  textTitle: "BDT \$${widget.productData!.productPrice}",
                  fontWeight: regularBoldFontWeight,
                  fontColor: greyColor,
                  isCenterText: true,
                  isClickAble: false,
                  fontSize: mediumTextSize,
                  textPadding: EdgeInsets.all(24),
                ),
                CustomIconButtonComponet(
                  icon: Icons.favorite_outline,
                  iconColor: redColor,
                  iconSize: mediumIconSize,
                  iconPadding: EdgeInsets.zero,
                ),
              ]),
              Container(
                width: customHeightWidth(context, width: true) * 0.8,
                decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: CustomTextComponet(
                  textTitle:
                      "${widget.productData!.productInstock} products in stock",
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
                  decoration: BoxDecoration(
                    color: blackColor.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0)),
                  ),
                  child: CustomTextComponet(
                    textTitle: widget.productData!.productDescription,
                    fontWeight: regularBoldFontWeight,
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
            similerProduct(maincategory: 'Men', width: width)
          ],
        ),
      ),
    );
  }
}

Widget similerProduct({String? maincategory, double? width}) {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection(productsDataDirectory)
      .where(productCollectionFieldMainCategory, isEqualTo: maincategory)
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
      );
    },
  );
}
