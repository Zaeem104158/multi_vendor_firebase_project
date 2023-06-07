import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class SellerDashBoardScreen extends StatefulWidget {
  SellerDashBoardScreen({super.key});

  @override
  State<SellerDashBoardScreen> createState() => _SellerDashBoardScreenState();
}

class _SellerDashBoardScreenState extends State<SellerDashBoardScreen> {
  List<String> title = [
    "My store",
    "Orders",
    "Edit Profile",
    "Manage Products",
    "Balance",
    "Statics"
  ];
  List<IconData> iconItem = [
    Icons.store,
    Icons.shop_2_outlined,
    Icons.edit,
    Icons.settings,
    Icons.attach_money,
    Icons.show_chart
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: CustomTextComponet(
          isClickAble: false,
          isCenterText: true,
          textTitle: "Seller DashBoard",
          fontWeight: regularBoldFontWeight,
          fontColor: blackColor,
          fontSize: appBarTitleTextSize,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: List.generate(
              6,
              (index) => Card(
                    color: blueGreyColor.withOpacity(0.8),
                    elevation: 15.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          iconItem[index],
                          size: 40,
                          color: cyanColor,
                        ),
                        CustomTextComponet(
                          isClickAble: true,
                          isCenterText: true,
                          textTitle: title[index].toUpperCase(),
                          fontWeight: regularBoldFontWeight,
                          fontColor: blackColor,
                          fontSize: smallTextSize,
                        )
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
