import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullImageScreen extends StatelessWidget {
  FullImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UiProvider uiProvider =
        Provider.of<UiProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: blueGreyColor.shade100.withOpacity(0.5),
      appBar: AppBar(
        elevation: 0.0,
        title: CustomTextComponet(
          textTitle: "Full Image",
          fontWeight: regularBoldFontWeight,
          fontColor: blackColor,
          isCenterText: true,
          isClickAble: false,
          fontSize: mediumTextSize,
        ),
        backgroundColor: blueGreyColor.shade100.withOpacity(0.5),
        leading: CustomIconButtonComponet(
          icon: Icons.arrow_back_ios_new,
          iconColor: blackColor,
          onPressed: () {
            navigationPop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedContainer(
              curve: Curves.easeInOutCubic,
              margin: EdgeInsets.all(10),
              duration: Duration(milliseconds: 500),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: CachedNetworkImage(
                    imageUrl: uiProvider.productData!
                        .productImageFile![uiProvider.pageControlSelectedIndex],
                    color: Colors.black.withOpacity(0.2),
                    colorBlendMode: BlendMode.darken,
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
          ),
          SizedBox(
            height: customHeightWidth(context, height: true) / 50,
          ),
          SizedBox(
            width: customHeightWidth(context, height: true),
            height: customHeightWidth(context, height: true) / 4,
            child: PageView.builder(
                clipBehavior: Clip.none,
                controller: uiProvider.pageController,
                onPageChanged: (page) {
                  uiProvider.updatePageControllerSelectedValue(page);
                },
                itemCount: uiProvider.productData!.productImageFile!.length,
                pageSnapping: true,
                itemBuilder: (context, pagePosition) {
                  bool active =
                      pagePosition == uiProvider.pageControlSelectedIndex;
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
                            imageUrl: uiProvider
                                .productData!.productImageFile![pagePosition],
                            color: Colors.black.withOpacity(0.2),
                            colorBlendMode: BlendMode.darken,
                            // height: 100,
                            // width: 100,
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
                  uiProvider.productData!.productImageFile!.length,
                  uiProvider.pageControlSelectedIndex)),
        ],
      ),
    );
  }
}
