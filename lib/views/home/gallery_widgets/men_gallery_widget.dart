import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/models/productdata_model_class.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MenGalleryWidget extends StatefulWidget {
  const MenGalleryWidget({super.key});

  @override
  State<MenGalleryWidget> createState() => _MenGalleryWidgetState();
}

class _MenGalleryWidgetState extends State<MenGalleryWidget> {
  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection(productsDataDirectory).snapshots();
  @override
  Widget build(BuildContext context) {
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

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 0.75,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot<Object?> productDataObject =
                snapshot.data!.docs[index];
            Map<String, dynamic> productData =
                productDataObject.data() as Map<String, dynamic>;
            final productDataModelClass =
                ProductDataModelClass.fromMap(productData);
            return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                  children: [
                    Text(productDataModelClass.subCategory!),
                    Image.network(
                      productDataModelClass.productImageFile![0],
                      fit: BoxFit.contain,
                    )
                  ],
                ));
          },
        );
      },
    );
  }
}
