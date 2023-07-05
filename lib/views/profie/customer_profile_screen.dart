import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/custom_box_container.dart';
import 'package:firebase_multi_vendor_project/components/custom_divider.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/icon_button_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/components/text_formfield_component.dart';
import 'package:firebase_multi_vendor_project/controllers/auth_controller.dart';
import 'package:firebase_multi_vendor_project/l10n/l10n.dart';
import 'package:firebase_multi_vendor_project/models/userInfo_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/cart/cart_screen.dart';
import 'package:firebase_multi_vendor_project/views/provider/ui_provider/ui_provider.dart';
import 'package:firebase_multi_vendor_project/views/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context, listen: true);
    AuthController authProvider =
        Provider.of<AuthController>(context, listen: false);
    final locale = uiProvider.locale;

    return FutureBuilder(
        future: authProvider.userCustomerInfo(),
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
            // snapshot.connectionState == ConnectionState.done
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final profileData = UserInfoModelClass.fromMap(data);
            return Scaffold(
              backgroundColor: greyColor.shade300,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: blueGreyColor.withOpacity(0.5),
                    automaticallyImplyLeading: false,
                    expandedHeight:
                        customHeightWidth(context, height: true) / 4.5,
                    flexibleSpace:
                        LayoutBuilder(builder: (context, constrains) {
                      return FlexibleSpaceBar(
                        centerTitle: true,
                        title: AnimatedOpacity(
                            opacity: constrains.biggest.height <= 120 ? 1 : 0,
                            duration: Duration(milliseconds: 300),
                            child: CustomTextComponet(
                              textTitle: AppLocalizations.of(context)!.profile,
                              fontColor: whiteColor,
                              fontWeight: regularBoldFontWeight,
                              fontSize: appBarTitleTextSize.sp,
                              textPadding: EdgeInsets.zero,
                            )),
                        background: Container(
                          height: 300.sp,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            cyanColor,
                            blackColor.withOpacity(0.8)
                          ])),
                          child: Padding(
                            padding: REdgeInsets.only(
                                top: 15.0, right: 15.0, left: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //! Image section
                                SizedBox(
                                  height: 120.sp,
                                  width: 120.sp,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 120.sp,
                                        width: 120.sp,
                                        decoration: BoxDecoration(
                                          //border: GradientBoxBorder(),
                                          borderRadius:
                                              BorderRadius.circular(100.sp),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            transform:
                                                GradientRotation(math.pi),
                                            colors: [
                                              Colors.redAccent,
                                              Colors.greenAccent,
                                              Colors.blueAccent,
                                            ],
                                          ),
                                          //    boxShadow: [
                                          //   BoxShadow(
                                          //       color: Colors.redAccent,
                                          //       blurRadius: 10.0.sp,
                                          //       offset: Offset(0, 0)),
                                          //   BoxShadow(
                                          //       color: Colors.greenAccent,
                                          //       blurRadius: 10.0.sp,
                                          //       offset: Offset(0, 0)),
                                          //   BoxShadow(
                                          //       color: Colors.blueAccent,
                                          //       blurRadius: 10.0.sp,
                                          //       offset: Offset(0, 0))
                                          // ]
                                        ),
                                        child: Center(
                                          child: ClipRRect(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                                height: 110.sp,
                                                width: 110.sp,
                                                imageUrl:
                                                    profileData.imageFile!,
                                                color:
                                                    blackColor.withOpacity(0.2),
                                                colorBlendMode:
                                                    BlendMode.darken,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                          child: CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress,
                                                              color: redColor
                                                                  .withOpacity(
                                                                      0.3)),
                                                        ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                          user_placeholder_image,
                                                          width: 110.sp,
                                                          height: 110.sp,
                                                          fit: BoxFit.fill,
                                                        ),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                      uiProvider.isImageEdit == false
                                          ? Positioned(
                                              top: 0.sp,
                                              left: 75.sp,
                                              child: GestureDetector(
                                                onTap: () {
                                                  authProvider
                                                      .deleteThenUpdateImage(
                                                          context,
                                                          imageFilePath:
                                                              profileData
                                                                  .imageFile);
                                                  uiProvider.setImageEdit();
                                                },
                                                child: Container(
                                                  height: 30.sp,
                                                  width: 30.sp,
                                                  decoration: BoxDecoration(
                                                      color: blackColor
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child:
                                                      CustomIconButtonComponet(
                                                    icon: Icons.edit,
                                                    iconColor: whiteColor,
                                                    iconSize: smallIconSize.sp,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Positioned(
                                              top: 0.sp,
                                              left: 75.sp,
                                              child: GestureDetector(
                                                onTap: () {
                                                  uiProvider.setImageEdit();
                                                },
                                                child: Container(
                                                  height: 30.sp,
                                                  width: 30.sp,
                                                  decoration: BoxDecoration(
                                                      color: blackColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.sp)),
                                                  child:
                                                      CustomIconButtonComponet(
                                                    icon: Icons.done,
                                                    iconColor: whiteColor,
                                                    iconSize: smallIconSize.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),

                                //! Name Section
                                Container(
                                  height: 120.sp,
                                  width: 200.sp,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      uiProvider.isFullNameEdit == false
                                          ? CustomTextComponet(
                                              maxLine: 3,
                                              textTitle: profileData.fullName ==
                                                          null ||
                                                      profileData.fullName == ""
                                                  ? "No Data"
                                                  : profileData.fullName,
                                              textPadding: EdgeInsets.zero,
                                              fontSize: smallTextSize.sp,
                                              fontWeight: FontWeight.bold,
                                              fontColor:
                                                  whiteColor.withOpacity(0.8),
                                              isCenterText: true,
                                            )
                                          : SizedBox(
                                              height: 40.sp,
                                              child:
                                                  CustomTextFormFieldComponent(
                                                isEmail: false,
                                                isValidate: false,
                                                textInputAction:
                                                    TextInputAction.done,
                                                inputFontColor: whiteColor,
                                                inputFontSize: smallTextSize.sp,
                                                padding: EdgeInsets.all(0.0),
                                                formFieldHintColor: whiteColor,
                                                isBorderEnable: false,
                                                isLable: false,
                                                formFieldhHintText: profileData
                                                                .fullName ==
                                                            null ||
                                                        profileData.fullName ==
                                                            ""
                                                    ? "Add Your Name Here"
                                                    : profileData.fullName,
                                                textEditingController: authProvider
                                                    .updateFullNameEditingController,
                                              ),
                                            ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      SizedBox(
                                        height: 30.sp,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            uiProvider.isFullNameEdit == true
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Map<Object, Object?>?
                                                          data = {
                                                        customersCollectionFieldFullName:
                                                            authProvider
                                                                .updateFullNameEditingController
                                                                .text
                                                      };
                                                      authProvider
                                                          .updateCustomerInfo(
                                                              data: data);
                                                      uiProvider
                                                          .setFullNameEdit();
                                                    },
                                                    child: Container(
                                                      height: 30.sp,
                                                      width: 80.sp,
                                                      decoration: BoxDecoration(
                                                          color: blackColor
                                                              .withOpacity(0.6),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp)),
                                                      child: Padding(
                                                        padding:
                                                            REdgeInsets.all(
                                                                2.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            CustomTextComponet(
                                                              textTitle:
                                                                  "Submit",
                                                              fontColor:
                                                                  whiteColor,
                                                              fontSize:
                                                                  smallTextSize
                                                                      .sp,
                                                              textPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              isCenterText:
                                                                  true,
                                                              isClickAble: true,
                                                            ),
                                                            CustomIconButtonComponet(
                                                              icon: Icons.done,
                                                              iconColor:
                                                                  whiteColor,
                                                              iconSize:
                                                                  smallIconSize
                                                                      .sp,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                uiProvider.setFullNameEdit();
                                              },
                                              child: Container(
                                                height: 30.sp,
                                                width: 70.sp,
                                                decoration: BoxDecoration(
                                                    color: blackColor
                                                        .withOpacity(0.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp)),
                                                child: Padding(
                                                  padding: REdgeInsets.all(2.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      CustomTextComponet(
                                                        textTitle: "Edit",
                                                        fontColor: whiteColor,
                                                        fontSize:
                                                            smallTextSize.sp,
                                                        textPadding:
                                                            EdgeInsets.zero,
                                                        isCenterText: true,
                                                        isClickAble: true,
                                                        onPressed: () {
                                                          uiProvider
                                                              .setFullNameEdit();
                                                        },
                                                      ),
                                                      CustomIconButtonComponet(
                                                        icon: uiProvider
                                                                    .isFullNameEdit ==
                                                                false
                                                            ? Icons.edit
                                                            : Icons
                                                                .cancel_outlined,
                                                        iconColor: whiteColor,
                                                        iconSize:
                                                            smallIconSize.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
                                    fontSize: smallTextSize.sp,
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
                                  fontSize: smallTextSize.sp,
                                  fontColor: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  isClickAble: true,
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
                                    fontSize: smallTextSize.sp,
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
                                  fontSize: regularTextSize.sp,
                                ),
                                subtitle: CustomTextComponet(
                                  textTitle: profileData.email,
                                  fontColor: greyColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: smallTextSize.sp,
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
                              // ! Phone Number Update
                              ListTile(
                                title: CustomTextComponet(
                                  textTitle: "Phone Number",
                                  fontColor: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: regularTextSize.sp,
                                ),
                                subtitle: SizedBox(
                                  height:
                                      customHeightWidth(context, height: true) /
                                          13,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      uiProvider.isPhoneNumberEdit == false
                                          ? CustomTextComponet(
                                              textTitle: profileData
                                                              .phoneNumber ==
                                                          null ||
                                                      profileData.phoneNumber ==
                                                          ""
                                                  ? "No Data"
                                                  : profileData.phoneNumber,
                                              fontColor: greyColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: smallTextSize.sp,
                                              textPadding: EdgeInsets.zero,
                                            )
                                          : Flexible(
                                              flex: 2,
                                              child:
                                                  CustomTextFormFieldComponent(
                                                isEmail: false,
                                                isValidate: false,
                                                textInputAction:
                                                    TextInputAction.done,
                                                inputFontSize: smallTextSize.sp,
                                                padding: EdgeInsets.all(0.0),
                                                isBorderEnable: false,
                                                isLable: false,
                                                formFieldhHintText: profileData
                                                                .phoneNumber ==
                                                            null ||
                                                        profileData
                                                                .phoneNumber ==
                                                            ""
                                                    ? "Add Here"
                                                    : profileData.phoneNumber,
                                                textEditingController: authProvider
                                                    .updatePhoneNumberEditingController,
                                              ),
                                            ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              uiProvider.setIsPhoneNumberEdit();
                                            },
                                            child: CustomIconButtonComponet(
                                              icon: uiProvider.isPhoneNumberEdit
                                                  ? Icons.cancel_outlined
                                                  : Icons.edit,
                                              iconSize:
                                                  listTileSmallIconSize.sp,
                                            ),
                                          ),
                                          uiProvider.isPhoneNumberEdit == true
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Map<Object, Object?>?
                                                        updateData = {
                                                      customersCollectionFieldPhoneNumber:
                                                          authProvider
                                                              .updatePhoneNumberEditingController
                                                              .text
                                                    };

                                                    authProvider
                                                        .updateCustomerInfo(
                                                            data: updateData);
                                                    uiProvider
                                                        .setIsPhoneNumberEdit();
                                                  },
                                                  child:
                                                      CustomIconButtonComponet(
                                                    icon: Icons.done,
                                                    iconSize:
                                                        listTileSmallIconSize
                                                            .sp,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                leading: CustomIconButtonComponet(
                                  icon: Icons.phone,
                                  iconSize: listTileMediumIconSize.sp,
                                ),
                              ),
                              CustomDivider(
                                withTextDivider: true,
                                onlyDivider: false,
                                width: double.infinity,
                                thickness: 1,
                                color: cyanColor,
                              ),
                              // ! Address
                              ListTile(
                                title: CustomTextComponet(
                                  textTitle: "Address",
                                  fontColor: blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: regularTextSize.sp,
                                ),
                                subtitle: SizedBox(
                                  height:
                                      customHeightWidth(context, height: true) /
                                          13,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      uiProvider.isAddressEdit == false
                                          ? Expanded(
                                              child: CustomTextComponet(
                                                textTitle: profileData
                                                                .address ==
                                                            null ||
                                                        profileData.address ==
                                                            ""
                                                    ? "No Data"
                                                    : profileData.address,
                                                fontColor: greyColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: smallTextSize.sp,
                                                textPadding: EdgeInsets.zero,
                                                maxLine: 5,
                                              ),
                                            )
                                          : Flexible(
                                              flex: 2,
                                              child:
                                                  CustomTextFormFieldComponent(
                                                isEmail: false,
                                                isValidate: false,
                                                textInputAction:
                                                    TextInputAction.done,
                                                inputFontSize: smallTextSize.sp,
                                                padding: EdgeInsets.all(0.0),
                                                isBorderEnable: false,
                                                isLable: false,
                                                formFieldhHintText: profileData
                                                                .address ==
                                                            null ||
                                                        profileData.address ==
                                                            ""
                                                    ? "Add Here"
                                                    : profileData.address,
                                                textEditingController: authProvider
                                                    .updateAddressEditingController,
                                              ),
                                            ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              uiProvider.setAddressEdit();
                                            },
                                            child: CustomIconButtonComponet(
                                              icon: uiProvider.isAddressEdit
                                                  ? Icons.cancel_outlined
                                                  : Icons.edit_location,
                                              iconSize:
                                                  listTileSmallIconSize.sp,
                                            ),
                                          ),
                                          uiProvider.isAddressEdit == true
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Map<Object, Object?> data =
                                                        {
                                                      customersCollectionFieldAddress:
                                                          authProvider
                                                              .updateAddressEditingController
                                                              .text
                                                    };
                                                    authProvider
                                                        .updateCustomerInfo(
                                                            data: data);
                                                    uiProvider.setAddressEdit();
                                                  },
                                                  child:
                                                      CustomIconButtonComponet(
                                                    icon: Icons.done,
                                                    iconSize:
                                                        listTileSmallIconSize
                                                            .sp,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                leading: CustomIconButtonComponet(
                                  icon: Icons.apartment,
                                  iconSize: listTileMediumIconSize.sp,
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
                          text: "Account Setting",
                          thickness: 1,
                          color: greyColor,
                        ),
                        CustomBoxContainer(
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
                                    authProvider.logoutCustomer(context),
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
                              CustomDivider(
                                width: double.infinity,
                                thickness: 1,
                                color: cyanColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: CustomTextComponet(
                                    isClickAble: true,
                                    textTitle: "Theme Mode",
                                    fontColor: blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  trailing: Switch(
                                    value: uiProvider.themeMode ==
                                        ThemeModeType.light,
                                    onChanged: (value) {
                                      ThemeModeType selectedThemeMode = value
                                          ? ThemeModeType.light
                                          : ThemeModeType.dark;
                                      uiProvider
                                          .saveThemeMode(selectedThemeMode);
                                    },
                                  ),
                                ),
                              ),
                              CustomDivider(
                                withTextDivider: true,
                                onlyDivider: false,
                                width: double.infinity,
                                thickness: 1,
                                color: cyanColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                    title: CustomTextComponet(
                                      isClickAble: true,
                                      textTitle: "Language Mode",
                                      fontColor: blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    trailing: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: locale,
                                        icon: Container(width: 12),
                                        items: L10n.all.map(
                                          (locale) {
                                            final flag = L10n.getFlag(
                                                locale.languageCode);

                                            return DropdownMenuItem(
                                              child: Center(
                                                child: Text(
                                                  flag,
                                                  style:
                                                      TextStyle(fontSize: 32),
                                                ),
                                              ),
                                              value: locale,
                                              onTap: () {
                                                uiProvider.setLocale(locale);
                                              },
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (_) {},
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: cyanColor,
            ),
          );
        }));
  }
}
