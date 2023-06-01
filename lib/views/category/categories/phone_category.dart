import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:flutter/material.dart';

class PhoneCategory extends StatelessWidget {
  const PhoneCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextComponet(
          textTitle: "Phones",
          isCenterText: true,
        )
      ],
    );
  }
}
