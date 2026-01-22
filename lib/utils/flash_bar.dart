import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';

class FlashBar {
  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(

      forwardAnimationCurve: Curves.decelerate,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.all(15),
      titleColor: Colors.white,

      borderRadius: BorderRadius.circular(10),
      reverseAnimationCurve: Curves.easeOut,

      flushbarPosition: FlushbarPosition.TOP,
      positionOffset: 20,
      // title: message,
      message: message,
      backgroundColor: Colors.black26,
    )..show(context));
  }
}