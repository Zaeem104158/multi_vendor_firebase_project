// // import 'dart:developer';
// // import 'dart:math';

// // import 'package:firebase_multi_vendor_project/components/text_component.dart';
// // import 'package:firebase_multi_vendor_project/utilits/style.dart';
// // import 'package:flutter/material.dart';

// // class Practice extends StatelessWidget {
// //   const Practice({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     int previousIndex = -1;
// //     // Store the previous index

// //     return Scaffold(
// //       backgroundColor: greyColor,
// //       appBar: AppBar(
// //         title: CustomTextComponet(
// //           textTitle: "Chess Board",
// //         ),
// //       ),
// //       body: ListView.builder(
// //         itemCount: 8,
// //         itemBuilder: (BuildContext context, int parentIndex) {
// //           return Container(
// //             height: 20, // finite height
// //             child: ListView.builder(
// //               itemCount: 8,
// //               shrinkWrap: true,
// //               scrollDirection: Axis.horizontal,
// //               itemBuilder: (BuildContext context, int index) {
// //                 int change = parentIndex.isOdd ? 1 : 0;

// //                 return (index + change).isEven
// //                     ? UnconstrainedBox(child: ChessBox(white: true))
// //                     : UnconstrainedBox(child: ChessBox(white: false));
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // Widget ChessBox({bool white = false}) {
// //   return Container(
// //     height: 20,
// //     width: 20,
// //     color: white ? Colors.white : Colors.black,
// //   );
// // }

// // // List<ColorModel> colorList = [
// // //   ColorModel(index: 0, color: Colors.red),
// // //   ColorModel(index: 1, color: Colors.green),
// // //   ColorModel(index: 2, color: Colors.blue),
// // //   ColorModel(index: 3, color: Colors.yellow),
// // //   ColorModel(index: 4, color: Colors.purple),
// // // ];

// // // class ColorModel {
// // //   int index;
// // //   Color color;

// // //   ColorModel({required this.index, required this.color});
// // // }

// // // Color getRandomColor(List<ColorModel> colorList, int previousIndex) {
// // //   Random random = Random();
// // //   int index = random.nextInt(colorList.length);
// // //   ColorModel randomColorModel = colorList[index];

// // //   // Check if the previous color value is the same as the new index color
// // //   if (previousIndex != null &&
// // //       colorList[previousIndex].color == randomColorModel.color) {
// // //     // Generate a new random index until it's different from the previous one
// // //     while (index == previousIndex) {
// // //       index = random.nextInt(colorList.length);
// // //       randomColorModel = colorList[index];
// // //     }
// // //   }

// // //   return randomColorModel.color;
// // // }

// // // import 'dart:math';
// // // import 'package:flutter/material.dart';

// // // class ColorModel {
// // //   int index;
// // //   Color color;

// // //   ColorModel({required this.index, required this.color});
// // // }

// // // class RandomColorList extends StatefulWidget {
// // //   @override
// // //   _RandomColorListState createState() => _RandomColorListState();
// // // }

// // // class _RandomColorListState extends State<RandomColorList> {
// // //   List<ColorModel> myColorList = [
// // //     ColorModel(index: 0, color: Colors.red),
// // //     ColorModel(index: 1, color: Colors.green),
// // //     ColorModel(index: 2, color: Colors.blue),
// // //     ColorModel(index: 3, color: Colors.yellow),
// // //   ];

// // //   int previousIndex = -1;

// // //   Color getRandomColor(List<ColorModel> colorList, int previousIndex) {
// // //     Random random = Random();
// // //     int index = random.nextInt(colorList.length);
// // //     ColorModel randomColorModel = colorList[index];

// // //     // Check if the previous color value is the same as the new index color
// // //     if (previousIndex != -1 &&
// // //         colorList[previousIndex].color == randomColorModel.color) {
// // //       // Generate a new random index until it's different from the previous one
// // //       while (index == previousIndex) {
// // //         index = random.nextInt(colorList.length);
// // //         randomColorModel = colorList[index];
// // //       }
// // //     }

// // //     return randomColorModel.color;
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //         appBar: AppBar(
// // //           title: Text('Random Color List'),
// // //         ),
// // //         body: Container(
// // //           height: 100,
// // //           width: 100,
// // //           decoration: BoxDecoration(
// // //             gradient: LinearGradient(colors: [Colors.pink, Colors.black]),
// // //           ),
// // //           child: Padding(
// // //             padding: const EdgeInsets.all(4.0),
// // //             child: Container(
// // //               color: Colors.grey,
// // //             ),
// // //           ),
// // //         )
// // //         //  ListView.builder(
// // //         //   itemCount: myColorList.length,
// // //         //   itemBuilder: (BuildContext context, int index) {
// // //         //     previousIndex = index;
// // //         //     Color currentColor = getRandomColor(myColorList, previousIndex);

// // //         //     return Container(
// // //         //       color: currentColor,
// // //         //       height: 100,
// // //         //       child: Center(
// // //         //         child: Text(
// // //         //           'Index: $index',
// // //         //           style: TextStyle(
// // //         //             color: Colors.white,
// // //         //             fontSize: 20,
// // //         //           ),
// // //         //         ),
// // //         //       ),
// // //         //     );
// // //         //   },
// // //         // ),
// // //         );
// // //   }
// // // }

// import 'dart:developer';

// import 'package:flutter/material.dart';

// class Page1 extends StatefulWidget {
//   static const String page1Name = '/page1';
//   const Page1({super.key});

//   @override
//   State<Page1> createState() => _Page1State();
// }

// class _Page1State extends State<Page1> {
//   // @override
//   // void initState() {
//   //   int x = ModalRoute.of(context)!.settings.arguments as int;
//   //   super.initState();
//   // }
//   // int? y;
//   // @override
//   // void didChangeDependencies() {
//   //   int x = ModalRoute.of(context)!.settings.arguments as int;
//   //   print(x);
//   //   if (x != null) {
//   //     y = x;
//   //   }
//   //   ;
//   //   super.didChangeDependencies();
//   // }
//   TextEditingController nameController = TextEditingController();
//   String name = "";
//   @override
//   void dispose() {
//     nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         TextFormField(
//           controller: nameController,
//         ),
//         IconButton(
//             onPressed: () {
//               setState(() {
//                 name = changeNAme();
//               });
//               log(name);
//             },
//             icon: Icon(Icons.add)),
//         Text(
//           "${name}",
//         ),
//       ],
//     )
//         // Center(
//         //     child: ElevatedButton(
//         //         onPressed: () {
//         //           Navigator.pushNamed(context, Page2.page2Name);
//         //         },
//         //         child: Column(
//         //           children: [Text("Go to Page 2"), Text("$y")],
//         //         ))),
//         );
//   }

//   String changeNAme() {
//     String name;
//     name = nameController.text;

//     return name != "" ? name : "No Data";
//   }
// }

// // class Page2 extends StatefulWidget {
// //   static const String page2Name = '/page2';
// //   const Page2({super.key});

// //   @override
// //   State<Page2> createState() => _Page2State();
// // }

// // class _Page2State extends State<Page2> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //           child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.pushNamed(context, Page3.page3Name);
// //               },
// //               child: Text("Go to Page 3"))),
// //     );
// //   }
// // }

// // class Page3 extends StatefulWidget {
// //   static const String page3Name = '/page3';
// //   const Page3({super.key});

// //   @override
// //   State<Page3> createState() => _Page3State();
// // }

// // class _Page3State extends State<Page3> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //           child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.pushNamedAndRemoveUntil(
// //                     context, Page1.page1Name, (context) => false,
// //                     arguments: 1);
// //               },
// //               child: Text("Gor to Home"))),
// //     );
// //   }
// // }
// // class Page3 extends StatefulWidget {
// //   static const String page3Name = '/page3';
// //   const Page3({super.key});

// //   @override
// //   State<Page3> createState() => _Page3State();
// // }

// // class _Page3State extends State<Page3> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //           child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.pushNamedAndRemoveUntil(
// //                     context, Page1.page1Name, (context) => false);
// //               },
// //               child: Text("Gor to Home"))),
// //     );
// //   }
// // }
// // class Page3 extends StatefulWidget {
// //   static const String page3Name = '/page3';
// //   const Page3({super.key});

// //   @override
// //   State<Page3> createState() => _Page3State();
// // }

// // class _Page3State extends State<Page3> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //           child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.pushNamedAndRemoveUntil(
// //                     context, Page1.page1Name, (context) => false);
// //               },
// //               child: Text("Gor to Home"))),
// //     );
// //   }
// // }
// // class Page6 extends StatefulWidget {
// //   static const String page6Name = '/page6';
// //   const Page6({super.key});

// //   @override
// //   State<Page6> createState() => _Page6State();
// // }

// // class _Page6State extends State<Page6> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //           child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.pushNamedAndRemoveUntil(
// //                     context, Page6.page6Name, (context) => true);
// //               },
// //               child: Text("Gor to Home"))),
// //     );
// //   }
// // }
// // class Page7 extends StatefulWidget {
// //   static const String page7Name = '/page7';
// //   const Page7({super.key});

// //   @override
// //   State<Page7> createState() => _Page7State();
// // }

// // class _Page7State extends State<Page3> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //           child: ElevatedButton(
// //               onPressed: () {
// //                 Navigator.pushNamedAndRemoveUntil(
// //                     context, Page7.page7Name, (context) => false,arguments: );
// //               },
// //               child: Text("Go to Page 3"))),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text('Go to Page 1'),
//               onPressed: () {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/page1', ModalRoute.withName('/'));
//               },
//             ),
//             ElevatedButton(
//               child: Text('Go to Page 2'),
//               onPressed: () {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/page2', ModalRoute.withName('/'));
//               },
//             ),
//             ElevatedButton(
//               child: Text('Go to Custom Page'),
//               onPressed: () {
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/custom', ModalRoute.withName('/'));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Page1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page 1'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Go Back'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }

// class Page2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Page 2'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Go Back'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }

// class CustomPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Go Back'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }
