import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/custom_box_container.dart';
import 'package:firebase_multi_vendor_project/components/custom_divider.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/models/userInfo_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/cart/cart_screen.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_multi_vendor_project/views/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();
    UiProvider themeProvider = Provider.of<UiProvider>(context);
    return FutureBuilder(
        future: authController.userCustomerInfo(),
        builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return CustomTextComponet(
              textTitle: "Something Went wrong",
              isClickAble: false,
              isCenterText: true,
            );
          } else if (snapshot.hasData && !snapshot.data!.exists) {
            return CustomTextComponet(
              isCenterText: true,
              textTitle: "Document doesn't exist",
              isClickAble: false,
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final profileData = UserInfoModelClass.fromMap(data);
            dismissLoading();
            return Scaffold(
              backgroundColor: greyColor.shade300,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: whiteColor,
                    automaticallyImplyLeading: false,
                    expandedHeight:
                        customHeightWidth(context, height: true) / 5,
                    flexibleSpace:
                        LayoutBuilder(builder: (context, constrains) {
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                            opacity: constrains.biggest.height <= 120 ? 1 : 0,
                            duration: Duration(milliseconds: 300),
                            child: CustomTextComponet(
                              textTitle: "Account",
                            )),
                        background: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            cyanColor,
                            blackColor.withOpacity(0.8)
                          ])),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                CustomBoxContainer(
                                  height:
                                      customHeightWidth(context, height: true) /
                                          5,
                                  width:
                                      customHeightWidth(context, width: true) /
                                          3,
                                  borderRadius: BorderRadius.circular(15),
                                  child: CircleAvatar(
                                    backgroundColor: blackColor,
                                    backgroundImage: NetworkImage(
                                        "${profileData.imageFile!}"),
                                  ),
                                ),
                                CustomTextComponet(
                                  textTitle: profileData.fullName,
                                  textPadding: EdgeInsets.all(8),
                                  fontSize: smallTextSize,
                                  fontWeight: FontWeight.bold,
                                  fontColor: whiteColor.withOpacity(0.8),
                                  // textOverflow: ,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        CustomSizedBox(
                          height:
                              customHeightWidth(context, height: true) / 100,
                        ),
                        CustomBoxContainer(
                          height: customHeightWidth(context, height: true) / 10,
                          width: customHeightWidth(context, width: true) * 0.9,
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigationPush(context,
                                      screenWidget: CartScreen());
                                },
                                child: Container(
                                  height:
                                      customHeightWidth(context, height: true) /
                                          20,
                                  width:
                                      customHeightWidth(context, width: true) *
                                          0.2,
                                  decoration: BoxDecoration(
                                      color: blackColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50.0),
                                          bottomLeft: Radius.circular(50.0))),
                                  child: CustomTextComponet(
                                    textTitle: "Cart",
                                    isCenterText: true,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    isClickAble: true,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    customHeightWidth(context, height: true) /
                                        20,
                                width: customHeightWidth(context, width: true) *
                                    0.2,
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
                              GestureDetector(
                                onTap: () {
                                  navigationPush(context,
                                      screenWidget: WishListScreen());
                                },
                                child: Container(
                                  height:
                                      customHeightWidth(context, height: true) /
                                          20,
                                  width:
                                      customHeightWidth(context, width: true) *
                                          0.2,
                                  decoration: BoxDecoration(
                                    color: blackColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50.0),
                                        bottomRight: Radius.circular(50.0)),
                                  ),
                                  child: CustomTextComponet(
                                    textTitle: "Wishlist",
                                    isCenterText: true,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    isClickAble: true,
                                  ),
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
                          height:
                              customHeightWidth(context, height: true) / 3.8,
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
                                  textTitle: profileData.email,
                                  fontColor: greyColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                                leading:
                                    CustomIconButtonComponet(icon: Icons.email),
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
                                leading:
                                    CustomIconButtonComponet(icon: Icons.phone),
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
                                leading: CustomIconButtonComponet(
                                    icon: Icons.location_city),
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
                          height:
                              customHeightWidth(context, height: true) / 3.5,
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
                                leading: CustomIconButtonComponet(
                                    icon: Icons.settings),
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
                                leading: CustomIconButtonComponet(
                                    icon: Icons.password),
                              ),
                              CustomDivider(
                                width: double.infinity,
                                thickness: 1,
                                color: cyanColor,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    authController.logoutCustomer(context),
                                child: ListTile(
                                  title: CustomTextComponet(
                                    isClickAble: true,
                                    textTitle: "Logout",
                                    fontColor: blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  leading: CustomIconButtonComponet(
                                      icon: Icons.logout),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Select Theme Mode:'),
                                  Switch(
                                    value: themeProvider.themeMode ==
                                        ThemeModeType.light,
                                    onChanged: (value) {
                                      ThemeModeType selectedThemeMode = value
                                          ? ThemeModeType.light
                                          : ThemeModeType.dark;
                                      themeProvider
                                          .saveThemeMode(selectedThemeMode);
                                    },
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Radio(
                              //       value: ThemeMode.light,
                              //       groupValue:
                              //           context.read<UiProvider>().themeMode,
                              //       onChanged: (value) {
                              //         context
                              //             .read<UiProvider>()
                              //             .saveThemeMode(value);
                              //       },
                              //     ),
                              //     Text('Light'),
                              //     Radio(
                              //       value: ThemeMode.dark,
                              //       groupValue:
                              //           context.read<UiProvider>().themeMode,
                              //       onChanged: (value) {
                              //         context
                              //             .read<UiProvider>()
                              //             .saveThemeMode(value);
                              //       },
                              //     ),
                              //     Text('Dark'),
                              //     Radio(
                              //       value: ThemeMode.system,
                              //       groupValue:
                              //           context.read<UiProvider>().themeMode,
                              //       onChanged: (value) {
                              //         context
                              //             .read<UiProvider>()
                              //             .saveThemeMode(value);
                              //       },
                              //     ),
                              //     Text('System'),
                              //   ],
                              // ),
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
          return Container();
        }));
  }
}
