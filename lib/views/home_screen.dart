import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: whiteColor,
        elevation: 0.0,
        title: GestureDetector(
          onTap: () {
            navigationPush(context, screenWidget: SearchScreen());
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
    );
  }
}
