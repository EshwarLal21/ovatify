
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Helper/appColor.dart';
import 'btn_custumize.dart';

void showCustomDialog({
  required BuildContext context,
  String? title,
  String? contentText,
  String? image,
  bool showLoader = false,
  String? button1Text,
  VoidCallback? onButton1Pressed,
  String? button2Text,
  VoidCallback? onButton2Pressed,
  bool autoClose = false,
  Duration autoCloseDuration = const Duration(seconds: 2),
  Color? btn1bgcolor,
  Color? btn1txtcolor,
  Color? btn1bordercolor,

  Color? btn2bgcolor,
  Color? btn2txtcolor,
  Color? btn2bordercolor,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      if (autoClose) {
        Future.delayed(autoCloseDuration, () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        });
      }

      return AlertDialog(
        backgroundColor: AppColors.darkgrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 4.h,),
            if (image != null) Image.asset(image),
            if (title != null)
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            if (contentText != null) ...[
              SizedBox(height: 10),
              Text(
                contentText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
            if (showLoader) ...[
              SizedBox(height: 20),
               SpinKitFadingCircle(
                color: AppColors.magenta,
                size: 40.0,
              ),
            ],
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (button1Text != null)...[
                  CustomButton(
                    height: 6.h,
                    width: 52.w,
                    fontsize: 14.sp,
                    borderRadius: 25,
                    onPressed: onButton1Pressed!,
                    title: button1Text,
                    borderColor: btn1bordercolor!,
                    backgroundColor: btn1bgcolor!,
                    textColor: btn1txtcolor!,
                  ),
                  SizedBox(height: 2.h,)
                ],
                if (button2Text != null) SizedBox(width: 10),
                if (button2Text != null)
                  CustomButton(
                    height: 6.h,
                    width: 52.w,
                    fontsize: 14.sp,
                    borderRadius: 25,
                    onPressed: onButton1Pressed!,
                    title: button2Text,
                    borderColor: btn2bordercolor!,
                    backgroundColor: btn2bgcolor!,
                    textColor: btn2txtcolor!,
                  ),

              ],
            ),
          ],
        ),
      );
    },
  );
}
