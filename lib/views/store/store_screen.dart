import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/models/sellerInfo_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/navigation_routs.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:firebase_multi_vendor_project/views/store/visit_store_screen.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: blueGreyColor.shade100.withOpacity(0.5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: customHeightWidth(context, height: true) / 8,
        elevation: 0.0,
        backgroundColor: greyColor,
        title: CustomTextComponet(
          textTitle: "Store",
          isCenterText: true,
          fontWeight: regularBoldFontWeight,
          fontSize: largeTextSize,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseFirestore.collection("sellers").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    QueryDocumentSnapshot<Object?> sellerInfo =
                        snapshot.data!.docs[index];
                    Map<String, dynamic> sellerInfoData =
                        sellerInfo.data() as Map<String, dynamic>;
                    final sellerData =
                        SellerInfoModelClass.fromMap(sellerInfoData);
                    return GestureDetector(
                      onTap: () {
                        navigationPush(context,
                            screenWidget: VisitStoreScreen(
                              sellerId: sellerData.sid,
                            ));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            width: 200,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              child: CachedNetworkImage(
                                  imageUrl: sellerData.imageFile!,
                                  color: Colors.black.withOpacity(0.2),
                                  colorBlendMode: BlendMode.darken,
                                  height: 200,
                                  width: 250,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      SizedBox(
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
                            textTitle: sellerData.fullName,
                          )
                        ],
                      ),
                    );
                  }));
            }),
      ),
    );
  }
}
