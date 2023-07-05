import 'package:firebase_multi_vendor_project/components/design_component.dart';
import 'package:firebase_multi_vendor_project/components/wave_clipper.dart';
import 'package:firebase_multi_vendor_project/utilits/style.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends AnimatedWidget {
  final Animation<double> animation;
  AnimatedBackground(this.animation) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      top: animation.value,
      child: ClipPath(
        clipper: WaveClipper(),
        child: Opacity(
          opacity: 0.5,
          child: Container(
            color: blackColor.withOpacity(0.3),
            width: 1000,
            height: customHeightWidth(context, height: true),
          ),
        ),
      ),
    );
  }
}
