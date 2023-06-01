import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:flutter/material.dart';

class KidsCategory extends StatelessWidget {
  const KidsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextComponet(
          textTitle: "Kids",
          isCenterText: true,
        ),
      ],
    );
  }
}
