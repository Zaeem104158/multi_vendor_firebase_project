import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/models/productdata_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
                      // decoration: BoxDecoration(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(15.0))),
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
          similerProduct(maincategory: 'Men')
        ],
      ),
    );
  }
}

Widget similerProduct({String? maincategory}) {
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

      return Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 0.65,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot<Object?> productDataObject =
                snapshot.data!.docs[index];
            //log("${snapshot.data!.docs[index].id}");
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
              child: Container(
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
                                      textDecoration:
                                          TextDecoration.lineThrough,
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
                          ),
                        ],
                      )
                    ],
                  )),
            );
          },
        ),
      );
    },
  );
}
