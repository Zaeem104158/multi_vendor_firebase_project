import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/text_component.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class WomenGalleryWidget extends StatelessWidget {
  const WomenGalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextComponet(
          textTitle: "Men",
          isCenterText: false,
          fontSize: appBarTitleTextSize,
          isClickAble: false,
          textPadding: EdgeInsets.zero,
        ),
        SizedBox(
          height: customHeightWidth(context, height: true) * 0.68,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            children: List.generate(
                5,
                (index) => Container(
                      color: cyanColor,
                      child: Text("data"),
                    )),
          ),
        ),
      ],
    );
  }
}
//Category Screen Folder last er 1 ta video baki ase.