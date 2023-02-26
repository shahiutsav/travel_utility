import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlushbar({
  required BuildContext context,
  required String message,
  Color color = Colors.yellow,
  IconData icon = Icons.call_missed_outgoing,
}) {
  Flushbar(
    message: message,
    messageColor: Colors.black,
    flushbarStyle: FlushbarStyle.FLOATING,
    borderColor: Colors.black,
    borderWidth: 3,
    backgroundColor: Colors.white,
    borderRadius: BorderRadius.circular(8),
    leftBarIndicatorColor: color,
    duration: const Duration(seconds: 3),
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    shouldIconPulse: false,
    isDismissible: true,
    onTap: (Flushbar flushbar) {
      flushbar.dismiss();
    },
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    margin: EdgeInsets.fromLTRB(
      18,
      18,
      18,
      MediaQuery.of(context).size.width / 5,
    ),
    icon: Icon(
      icon,
      size: 28.0,
      color: color,
    ),
  ).show(context);
}
