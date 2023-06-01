import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerSearchScreen extends StatelessWidget {
  const CustomerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: IconThemeData(color: blackColor),
        elevation: 0.0,
        title: CupertinoSearchTextField(),
      ),
      body: Text("Search"),
    );
  }
}
