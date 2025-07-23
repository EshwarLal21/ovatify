
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ovatify/View/trackMetadata_Screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'Standard_ArtistScreen.dart';
import 'home_Screen.dart';
import 'main_Screen.dart';

class ListTrackerScreen extends StatefulWidget {
  @override
  _ListTrackerScreenState createState() => _ListTrackerScreenState();
}

class _ListTrackerScreenState extends State<ListTrackerScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    // if (index == 2) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(initialIndex: index),
      ),
    );
  }


  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) _count--;
    });
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(


      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.center,
                  child: CustomLabelText(
                    text: 'View details',
                    color: AppColors.white,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 2.h),

                CustomLabelText(
                  text: 'Track Metadata',
                  fontSize: 16.sp,
                  color: Colors.white,
                ),

                SizedBox(height: 2.h,),
                Divider(height: 1.h, thickness: .03.h,),
                SizedBox(height: 2.h,),
                SizedBox(height: 2.h),
                SizedBox(height: 2.h),


                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabelText(
                      text: 'BPM',
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ),
                    CustomLabelText(
                      text: 'Mood',
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ),
                     CustomLabelText(
                      text: 'Instrument',
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ),

                  ],),
                SizedBox(
                  height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabelText(
                      text: '120',
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                    CustomLabelText(
                      text: 'Uplifting',
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                    CustomLabelText(
                      text: 'Bass',
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),

                  ],),

                SizedBox(height: 2.h),

                CustomLabelText(
                  text: 'Attached Agreement',
                  fontSize: 16.sp,
                  color: Colors.white,
                ),

                SizedBox(height: 2.h,),
                Divider(height: 1.h, thickness: .03.h,),
                SizedBox(height: 2.h,),


                SizedBox(height: 2.h,),
                Container(
                  height: 4.h,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomLabelText(
                        text: 'Standard Agreement.pdf',
                        color: Colors.white,
                      ),
                      CustomLabelText(
                        text: 'View',
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 33.h),
                CustomButton(title: 'List Track', onPressed: () {

                  Get.to(() => TrackmetadataScreen());
                },),
                SizedBox(height: 3.h),
                CustomButton(
                  title: 'Distribute to DSPs',
                  onPressed: () {  },
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.grey,
                ),
                SizedBox(height: 3.h),

              ],
            ),
          ),
        ),
      ),



    );
  }
}


