import 'package:firebase_multi_vendor_project/components/custom_box_container.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/category/categories/kids_category.dart';
import 'package:firebase_multi_vendor_project/views/category/categories/men_category.dart';
import 'package:firebase_multi_vendor_project/views/category/categories/phone_category.dart';
import 'package:firebase_multi_vendor_project/views/category/categories/women_cateory.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ItemData> item = [
    ItemData(itemName: "Men"),
    ItemData(itemName: "Women"),
    ItemData(itemName: "Kids"),
    ItemData(itemName: "Phone")
  ];

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: SizedBox(
              height: customHeightWidth(context, height: true) * 0.8,
              width: customHeightWidth(context, width: true) * 0.2,
              child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: ((context, int index) {
                    return GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(index);
                      },
                      child: Container(
                        color: item[index].isSelected
                            ? whiteColor
                            : Colors.grey.shade300,
                        height: customHeightWidth(context, height: true) / 8,
                        child: CustomTextComponet(
                          textTitle: "${item[index].itemName}",
                          isClickAble: true,
                          isCenterText: true,
                        ),
                      ),
                    );
                  })),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: CustomBoxContainer(
              height: customHeightWidth(context, height: true) * 0.8,
              width: customHeightWidth(context, width: true) * 0.8,
              color: whiteColor,
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: pageController,
                onPageChanged: (value) {
                  for (var element in item) {
                    element.isSelected = false;
                  }
                  setState(() {
                    item[value].isSelected = true;
                  });
                },
                children: [
                  MenCategory(),
                  WomenCategory(),
                  KidsCategory(),
                  PhoneCategory()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemData {
  final String? itemName;
  bool isSelected;
  ItemData({this.itemName, this.isSelected = false});
}
