
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'Standard_ArtistScreen.dart';
import 'home_Screen.dart';
import 'main_Screen.dart';

class ViewtrackconsumerScreen extends StatefulWidget {
  @override
  _ViewtrackconsumerScreenState createState() => _ViewtrackconsumerScreenState();
}

class _ViewtrackconsumerScreenState extends State<ViewtrackconsumerScreen> {


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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(AppImages.profile),
                    ),

                    SizedBox(width: 4.w),
                    Column(
                      children: [
                        CustomLabelText(
                          text: 'Luna Beats',
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                        CustomLabelText(
                          text: 'Pop music expert',
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.h,),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 30.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.inspirationpic),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.islpb, scale: 0.71,),
                            SizedBox(width: 2.w,),
                            Image.asset(AppImages.waves),
                            SizedBox(width: 4.w,),

                            CustomLabelText(text: '02:00', color: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Description',
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Lorem ipsum dolor sit amet consectetur. Gravida morbi cras scelerisque tortor etiam dignissim tincidunt pharetra consequat. Diam ac blandit a in pellentesque egestas. Vel consequat sed id eget semper neque risus neque odio. In morbi nisi facilisi faucibus cursus felis faucibus nisi. Odio lectus at dictum ullamcorper sodales semper fames venenatis arcu. Ultricies molestie placerat scelerisque id mattis hendrerit odio et. Porttitor penatibus rhoncus sit odio at eu magna. Dui lectus aenean viverra molestie etiam lacus ullamcorper.',
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                ),


                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabelText(
                      text: 'License Type',
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ), CustomLabelText(
                      text: 'Date Licensed',
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ), CustomLabelText(
                      text: 'Price Paid',
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ),
                  ],
                ),

                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    CustomLabelText(
                      text: 'Personal',
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ), CustomLabelText(
                      text: 'April 12, 2025',
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ), CustomLabelText(
                      text: '\$120',
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ],
                ),









                SizedBox(height: 5.h),
                CustomButton(title: 'Download Track', onPressed: () {

                  Get.to(() => ArtistAgreementScreen());
                },),
                SizedBox(height: 3.h),
                CustomButton(
                  title: 'View Agreement',
                  onPressed: () {
                    Get.to(() => ArtistAgreementScreen());
                  },
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


