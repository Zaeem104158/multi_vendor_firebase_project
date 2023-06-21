import 'package:flutter/material.dart';

void navigationPush(BuildContext context,
    {required Widget screenWidget, bool removeUntil = true}) {
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screenWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Navigator.pushAndRemoveUntil(
      context, _createRoute(), (context) => removeUntil);
}

void navigationPop(
  BuildContext context,
) {
  Navigator.pop(context);
}
