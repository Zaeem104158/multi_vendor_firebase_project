// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_multi_vendor_project/components/design_component.dart';
// import 'package:firebase_multi_vendor_project/components/product_card_component.dart';
// import 'package:firebase_multi_vendor_project/components/text_component.dart';
// import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
// import 'package:firebase_multi_vendor_project/utilits/style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyAnimationWidget extends AnimatedWidget {
//   final Animation<double> animation;
//   MyAnimationWidget(this.animation) : super(listenable: animation);

//   final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
//       .collection(productsDataDirectory)
//       .where(productCollectionFieldMainCategory, isEqualTo: 'Women')
//       .snapshots();

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     return StreamBuilder<QuerySnapshot>(
//       stream: _productsStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: cyanColor,
//             ),
//           );
//         }
//         if (snapshot.data!.docs.isEmpty) {
//           final Color backgroundColor = blackColor.withOpacity(0.5);
//           return Container(
//             child: Stack(
//               children: [
//                 Positioned(
//                   bottom: 0,
//                   top: animation.value,
//                   child: ClipPath(
//                     clipper: WaveClipper(),
//                     child: Opacity(
//                       opacity: 0.5,
//                       child: Container(
//                         color: backgroundColor,
//                         width: 1000,
//                         height: customHeightWidth(context, height: true),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         final Color backgroundColor = blackColor.withOpacity(0.5);
//         return Container(
//           child: Stack(
//             children: [
//               Positioned(
//                 bottom: 0,
//                 top: animation.value,
//                 child: ClipPath(
//                   clipper: WaveClipper(),
//                   child: Opacity(
//                     opacity: 0.5,
//                     child: Container(
//                       color: backgroundColor,
//                       width: 1000,
//                       height: customHeightWidth(context, height: true),
//                     ),
//                   ),
//                 ),
//               ),
//               ProductCardComponent(
//                 productDataLength: snapshot.data!.docs.length,
//                 gridProductRow: 2,
//                 gridAspectRatio: 0.55,
//                 screenWidth: width,
//                 snapshot: snapshot,
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class WaveClipper extends CustomClipper<Path> {
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }

//   @override
//   Path getClip(Size size) {
//     double w = size.width;
//     double h = size.height;
//     var path = Path();
//     path.lineTo(0, h / 2);
//     path.quadraticBezierTo(w * 0.75, h - 200, w, h - 2000);
//     path.lineTo(w, 0);
//     path.close();
//     return path;
//   }
// }

// class WomenGalleryWidget extends StatefulWidget {
//   @override
//   _MyAnimationState createState() => _MyAnimationState();
// }

// class _MyAnimationState extends State<WomenGalleryWidget>
//     with SingleTickerProviderStateMixin {
//   late Animation<double> animation;
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(seconds: 3),
//       vsync: this,
//     );
//     animation = Tween<double>(begin: 00, end: -50).animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           _controller.forward();
//         }
//       });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.stop();
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyAnimationWidget(animation);
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_multi_vendor_project/components/product_card_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/common_constants.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class WomenGalleryWidget extends StatelessWidget {
  // final Animation<double> animation;

  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection(productsDataDirectory)
      .where(productCollectionFieldMainCategory, isEqualTo: 'Women')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
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
        if (snapshot.data!.docs.isEmpty) {
          return CustomTextComponet(
            textTitle: "This category\nhas not data yet.",
            maxLine: 3,
            fontSize: largeTextSize,
            fontWeight: regularBoldFontWeight,
            fontColor: redColor.withOpacity(0.5),
            isCenterText: true,
          );
        }

        return ProductCardComponent(
          productDataLength: snapshot.data!.docs.length,
          gridProductRow: 2,
          gridAspectRatio: 0.55,
          screenWidth: width,
          snapshot: snapshot,
        );
      },
    );
  }
}
