
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ovatify/View/view_MarketingDetailsScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'QmeJobHub_Screen.dart';
import 'home_Screen.dart';
import 'main_Screen.dart';

class MarketingScreen extends StatefulWidget {
  @override
  _MarketingScreenState createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  String selectedChip = 'All';

  final List<String> chipLabels = ['All', 'Loops', 'Loops', 'Drums'];
  void _onItemTapped(int index) {
    // if (index == 2) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(initialIndex: index),
      ),
    );
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
                SizedBox(height: 6.h),
                Align(
                    alignment: Alignment.centerLeft,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Image.asset(AppImages.title, scale: 6,),
                        CustomLabelText(
                          text: 'Hey!',
                          color: AppColors.magenta,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        ),
                        CustomLabelText(
                          text: 'Your Marketplace',
                          color: AppColors.white,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        )
                      ],
                    )),
                SizedBox(height: 2.h),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[850],
                    hintText: 'Search song',
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.search, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 2.h),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                    Row(
                      children: chipLabels
                          .map(
                            (label) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              label,
                              style: TextStyle(
                                color: selectedChip == label
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                            ),
                            selected: selectedChip == label,
                            showCheckmark: false,
                            backgroundColor: Colors.black,
                            selectedColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                selectedChip = label;
                              });
                            },
                          ),
                        ),
                      )
                          .toList(),
                    )

                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Featured Drops',
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  height: 28.h,

                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 39.w,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12), bottom: Radius.circular(12)),
                                  child: Image.asset(AppImages.inspirationpic, height: 28.h, width: double.infinity, fit: BoxFit.cover),
                                ),
                                Positioned(
                                  top: 4.h,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      Image.asset(AppImages.islpb),
                                      SizedBox(height: 1.h,),
                                      Image.asset(AppImages.waves,),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 4.h,
                                  child:

                                  Column(

                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                        children: [
                                          SizedBox(width: 3.w,),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomLabelText(text: 'Cloudside',color: AppColors.white,fontSize: 14.sp,fontWeight: FontWeight.w300,),
                                              CustomLabelText(text: 'Luna Beats',color: AppColors.white,fontSize: 14.sp,fontWeight: FontWeight.w300,),

                                            ],
                                          ),
                                          SizedBox(width: 6.w,),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[850],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child:
                                            CustomLabelText(text:  "\$19",color: AppColors.white,fontSize: 14.sp,fontWeight: FontWeight.w300,),

                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 2.h,),
                                      CustomButton(
                                        title: 'View details',
                                        fontsize: 13.sp,
                                        borderRadius: 10.sp,
                                        backgroundColor: AppColors.primary,
                                        borderColor: AppColors.primary,
                                        onPressed: () {
                                          Get.to(() =>ViewMarketingdetailsscreen());

                                        },
                                        height: 4.h,
                                        width: 30.w,

                                      ),
                                    ],
                                  ),

                                )
                              ],
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ),
                CustomLabelText(
                  text: 'Trending Now',
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Get.to(() => QmejobhubScreen());

                        },
                        child: Container(
                          width: 40.w,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                    child: Image.asset(AppImages.inspirationpic, height: 14.h, width: double.infinity, fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Image.asset(AppImages.islpb),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Cloudside", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                            Text("Luna Beats", style: TextStyle(color: Colors.grey)),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[850],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "\$19",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 1.h,),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(AppImages.profile),
                                        ),

                                        SizedBox(width: 10),
                                        CustomLabelText(
                                          text: 'Luna Beats',
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 3.h),
                CustomLabelText(
                  text: 'Invest in music',
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 1.h),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 15.h,
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: AppColors.darkgrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  AppImages.inspirationpic,
                                  scale: 2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    AppImages.islpb,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Family memories", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 0.7.h,),

                                  Text("100 Blocks | 75 Available", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                                  SizedBox(height: 0.7.h,),
                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.green,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text("ROI: 12%", style: TextStyle(color: Colors.white, fontSize: 12.sp))),
                                  SizedBox(height: 1.h,),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundImage: AssetImage(AppImages.profile),
                                      ),

                                      SizedBox(width: 10),
                                      CustomLabelText(
                                        text: 'Kasandra Cabrera',
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, size: 18.sp, color: AppColors.primary),
                          SizedBox(width: 5.w,),
                        ],
                      ),
                    );
                  },
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


