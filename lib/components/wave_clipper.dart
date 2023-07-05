import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    var path = Path();
    path.lineTo(0, h / 2);
    path.quadraticBezierTo(w * 0.75, h - 200, w, h - 2000);
    path.lineTo(w, 0);
    path.close();
    return path;
  }
}
