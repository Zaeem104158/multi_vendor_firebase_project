// import 'package:firebase_multi_vendor_project/utilits/style.dart';
// import 'package:flutter/material.dart';

// class NoDataFoundCard extends StatelessWidget {
//   final String? title;
//   final String? subtitle;
//   final bool isTranslate;
//   final IconData? noDataFoundCardIcon;
//   final String? searchKey;
//   final EdgeInsetsGeometry? margin;
//   final VoidCallback? onPressed;

//   const NoDataFoundCard(
//       {Key? key,
//       this.searchKey,
//       this.title,
//       this.subtitle,
//       this.isTranslate = true,
//       required this.onPressed,
//       this.margin = const EdgeInsets.only(top: 28, left: 32),
//       this.noDataFoundCardIcon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 32),
//       //height:100 ,

//       width: MediaQuery.of(context).size.width,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(28.0),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 28.0),
//               child: Icon(
//                 noDataFoundCardIcon,
//                 size: mediumIconSize,
//                 color: redColor,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: Text(
//                 isTranslate ? title?.tr() ?? "" : title ?? "",
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                     fontWeight: regularFontWeight,
//                     fontFamily: latoFont,
//                     fontSize: memberNameFontSize),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0, left: 46, right: 46),
//               child: Text(
//                 isTranslate ? subtitle?.tr() ?? "" : subtitle ?? "",
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                     fontWeight: regularFontWeight,
//                     fontFamily: latoFont,
//                     fontSize: noDataFoundRegularFontSize,
//                     color: Color(0xff50535D)),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 0.0, bottom: 10),
//               child: ElevatedButton(
//                 onPressed: onPressed,
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(100), // <-- Radius
//                   ),
//                 ),
//                 child:
//                     Text(isTranslate ? searchKey?.tr() ?? "" : searchKey ?? "",
//                         textAlign: TextAlign.center,
//                         //maxLines: 1,
//                         overflow: TextOverflow.ellipsis),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
