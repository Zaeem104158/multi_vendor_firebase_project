import 'package:flutter/material.dart';

void navigationPush(BuildContext context, {required Widget screenWidget}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return screenWidget;
    }),
  );
}

void navigationPop(
  BuildContext context,
) {
  Navigator.pop(context);
}
