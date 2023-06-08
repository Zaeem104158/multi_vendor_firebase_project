import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/category/category_list/category_list.dart';
import 'package:firebase_multi_vendor_project/views/home/gallery_widgets/accessories_gallery_widget.dart';
import 'package:firebase_multi_vendor_project/views/home/gallery_widgets/beauty_gallery_widget.dart';
import 'package:firebase_multi_vendor_project/views/home/gallery_widgets/electornics_gallery_widget.dart';
import 'package:firebase_multi_vendor_project/views/home/gallery_widgets/kids_gallery_widget.dart';
import 'package:firebase_multi_vendor_project/views/home/gallery_widgets/men_gallery_widget.dart';
import 'package:firebase_multi_vendor_project/views/home/gallery_widgets/shoes_gallery_widget.dart';
import 'package:firebase_multi_vendor_project/views/home/gallery_widgets/women_gallery_widget.dart';
import 'package:firebase_multi_vendor_project/views/search/customer_search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: mainCategoryList.length - 1,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: blueGreyColor.shade100.withOpacity(0.5),
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: blueGreyColor.withOpacity(0.6),
            isScrollable: true,
            tabs: mainCategoryList
                .sublist(1)
                .map(
                  (String item) => Container(
                    height: customHeightWidth(context, height: true) * 0.03,
                    width: customHeightWidth(context, width: true) * 0.25,
                    decoration: BoxDecoration(
                        color: blackColor.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: CustomTextComponet(
                      isClickAble: true,
                      isCenterText: true,
                      textTitle: item,
                      fontSize: smallTextSize,
                      fontWeight: regularBoldFontWeight,
                      textPadding: EdgeInsets.zero,
                    ),
                  ),
                )
                .toList(),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0.0,
          title: GestureDetector(
            onTap: () {
              navigationPush(context, screenWidget: CustomerSearchScreen());
            },
            child: Container(
              height: customHeightWidth(context, height: true) / 20,
              width: customHeightWidth(context, width: true) / 1.2,
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 2, color: blackColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(25.0)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextComponet(
                      textTitle: "What are you looking for",
                      isClickAble: true,
                      textPadding: EdgeInsets.only(left: 8, top: 2),
                      fontSize: 16.0,
                    ),
                    CustomIconButtonComponet(
                      icon: Icons.search,
                      iconPadding: EdgeInsets.all(2.0),
                      iconSize: 24.0,
                    )
                  ]),
            ),
          ),
        ),
        body: TabBarView(children: [
          MenGalleryWidget(),
          WomenGalleryWidget(),
          KidsGalleryWidget(),
          ElectornicsGalleryWidget(),
          ShoesGalleryWidget(),
          BeautyGalleryWidget(),
          AccessoriesGalleryWidget(),
        ]),
      ),
    );
  }
}
