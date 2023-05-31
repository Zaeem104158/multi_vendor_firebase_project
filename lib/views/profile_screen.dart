import 'package:firebase_multi_vendor_project/components/custom_box_container.dart';
import 'package:firebase_multi_vendor_project/components/custom_divider.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor.shade300,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: whiteColor,
            automaticallyImplyLeading: false,
            expandedHeight: customHeightWidth(context, height: true) / 5,
            flexibleSpace: LayoutBuilder(builder: (context, constrains) {
              return FlexibleSpaceBar(
                title: AnimatedOpacity(
                    opacity: constrains.biggest.height <= 120 ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: CustomTextComponet(
                      textTitle: "Account",
                    )),
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [cyanColor, blackColor.withOpacity(0.8)])),
                  child: CircleAvatar(),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomSizedBox(
                  height: customHeightWidth(context, height: true) / 100,
                ),
                CustomBoxContainer(
                  height: customHeightWidth(context, height: true) / 10,
                  width: customHeightWidth(context, width: true) * 0.9,
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomBoxContainer(
                        height: customHeightWidth(context, height: true) / 20,
                        width: customHeightWidth(context, width: true) * 0.2,
                        color: blackColor.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            bottomLeft: Radius.circular(50.0)),
                        child: CustomTextComponet(
                          textTitle: "Cart",
                          isCenterText: true,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          isClickAble: true,
                          onPressed: () {},
                        ),
                      ),
                      CustomBoxContainer(
                        height: customHeightWidth(context, height: true) / 20,
                        width: customHeightWidth(context, width: true) * 0.2,
                        color: cyanColor,
                        child: CustomTextComponet(
                          textTitle: "Order",
                          isCenterText: true,
                          fontSize: 16,
                          fontColor: whiteColor,
                          fontWeight: FontWeight.bold,
                          isClickAble: true,
                          onPressed: () {},
                        ),
                      ),
                      CustomBoxContainer(
                        height: customHeightWidth(context, height: true) / 20,
                        width: customHeightWidth(context, width: true) * 0.2,
                        color: blackColor.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0)),
                        child: CustomTextComponet(
                          textTitle: "Wishlist",
                          isCenterText: true,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          isClickAble: true,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDivider(
                  mainAxisAlignment: MainAxisAlignment.center,
                  isCenter: true,
                  withTextDivider: true,
                  onlyDivider: false,
                  text: "Account Info",
                  thickness: 1,
                  color: greyColor,
                ),
                CustomBoxContainer(
                  height: customHeightWidth(context, height: true) / 3.8,
                  padding: EdgeInsets.all(24),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(15.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: CustomTextComponet(
                          textTitle: "Email Address",
                          fontColor: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        subtitle: CustomTextComponet(
                          textTitle: "zaeemhasan007@gmail.com",
                          fontColor: greyColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                        leading: CustomIconButtonComponet(icon: Icons.email),
                      ),
                      CustomDivider(
                        withTextDivider: true,
                        onlyDivider: false,
                        width: double.infinity,
                        thickness: 1,
                        color: cyanColor,
                      ),
                      ListTile(
                        title: CustomTextComponet(
                          textTitle: "Phone Number",
                          fontColor: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        subtitle: CustomTextComponet(
                          textTitle: "+8801521203530",
                          fontColor: greyColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                        leading: CustomIconButtonComponet(icon: Icons.phone),
                      ),
                      CustomDivider(
                        withTextDivider: true,
                        onlyDivider: false,
                        width: double.infinity,
                        thickness: 1,
                        color: cyanColor,
                      ),
                      ListTile(
                        title: CustomTextComponet(
                          textTitle: "Address",
                          fontColor: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        subtitle: CustomTextComponet(
                          textTitle: "Dhaka",
                          fontColor: greyColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                        leading:
                            CustomIconButtonComponet(icon: Icons.location_city),
                      ),
                    ],
                  ),
                ),
                CustomDivider(
                  mainAxisAlignment: MainAxisAlignment.center,
                  isCenter: true,
                  withTextDivider: true,
                  onlyDivider: false,
                  text: "Account Setting",
                  thickness: 1,
                  color: greyColor,
                ),
                CustomBoxContainer(
                  height: customHeightWidth(context, height: true) / 4.8,
                  padding: EdgeInsets.all(24),
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(15.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: CustomTextComponet(
                          textTitle: "Edit Profile",
                          fontColor: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        leading: CustomIconButtonComponet(icon: Icons.settings),
                      ),
                      CustomDivider(
                        width: double.infinity,
                        thickness: 1,
                        color: cyanColor,
                      ),
                      ListTile(
                        title: CustomTextComponet(
                          textTitle: "Change Password",
                          fontColor: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        leading: CustomIconButtonComponet(icon: Icons.password),
                      ),
                      CustomDivider(
                        width: double.infinity,
                        thickness: 1,
                        color: cyanColor,
                      ),
                      ListTile(
                        title: CustomTextComponet(
                          textTitle: "Logout",
                          fontColor: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        leading: CustomIconButtonComponet(icon: Icons.logout),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
