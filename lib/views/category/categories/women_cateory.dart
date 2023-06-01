import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:flutter/material.dart';

class WomenCategory extends StatelessWidget {
  const WomenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextComponet(
          textTitle: "Women",
          isCenterText: true,
        ),
      ],
    );
  }
}
