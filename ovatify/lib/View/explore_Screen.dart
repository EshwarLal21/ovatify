
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'home_Screen.dart';
import 'main_Screen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  String selectedChip = 'Beats';

  final List<String> chipLabels = ['Beats', 'Vocals', 'Loops', 'Drums'];
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
                      Image.asset(AppImages.title, scale: 6),
                      CustomLabelText(
                        text: 'Hey!',
                        color: AppColors.magenta,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                      CustomLabelText(
                        text: 'Explore content',
                        color: AppColors.white,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      )
                    ],
                  ),
                ),
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
                  child: Row(
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
                  ),
                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Featured Drops',
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  height: 28.h,  // fits perfectly
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 40.w,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppColors.darkgrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.asset(
                                AppImages.inspirationpic,
                                height: 14.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // First row (Title & price)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Cloudside",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "Luna Beats",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                                  SizedBox(height: 0.8.h),
                                  // Second row (Avatar & artist name)
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundImage: AssetImage(AppImages.profile),
                                      ),
                                      SizedBox(width: 8),
                                      CustomLabelText(
                                        text: 'Luna Beats',
                                        fontSize: 13.sp,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                      decoration: BoxDecoration(
                        color: AppColors.darkgrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              AppImages.inspirationpic,
                              height: 15.h,
                              width: 30.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Family memories",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500)),
                                  Text("100 Blocks | 75 Available",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.sp)),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text("ROI: 12%",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp)),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundImage:
                                        AssetImage(AppImages.profile),
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
                          Icon(Icons.arrow_forward_ios,
                              size: 18.sp, color: AppColors.primary),
                          SizedBox(width: 5.w),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 3.h),
                CustomButton(
                  title: 'Become a creator',
                  fontsize: 16.sp,
                  borderRadius: 15.sp,
                  backgroundColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


