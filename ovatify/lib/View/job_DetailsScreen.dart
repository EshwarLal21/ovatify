import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../data/apiHelper.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'ApplyforJob_Screen.dart';
import 'main_Screen.dart';

class JobDetailsscreen extends StatefulWidget {
  @override
  _JobDetailsscreenState createState() => _JobDetailsscreenState();
}

class _JobDetailsscreenState extends State<JobDetailsscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;

  List<dynamic> jobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await ApiService.get('/job', headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });
    print(response.statusCode);

    final data = jsonDecode(response.body);
    print(data);
    if (data['success']) {
      setState(() {
        jobs = data['data'];
        isLoading = false;
      });
    } else {
      print('Error: ${data['message']}');
      setState(() => isLoading = false);
    }
  }

  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (jobs.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(child: Text("No jobs found", style: TextStyle(color: Colors.white))),
      );
    }

    final job = jobs[0]; // You can change this to show a specific job

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
                    text: 'View Job details',
                    color: AppColors.white,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: job['title'] ?? '',
                  color: AppColors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                              text: job['user']?['email'] ?? '',
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                            CustomLabelText(
                              text: 'Job Poster',
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomLabelText(
                      text: '\$${job['price']}',
                      color: AppColors.white,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Description',
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: job['description'] ?? '',
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                ),
                SizedBox(height: 4.h),
                CustomLabelText(
                  text: 'Requirements',
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: job['requirements'] ?? '',
                  color: AppColors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                ),
                SizedBox(height: 3.h),
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    job['tags']?.length ?? 0,
                        (index) => CustomButton(
                      title: job['tags'][index],
                      fontsize: 14.sp,
                      borderRadius: 18.sp,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.primary,
                      onPressed: () {},
                      width: 35.w,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                CustomButton(
                  title: 'Apply Now',
                  onPressed: () {
                    Get.to(() => ApplyforjobScreen(title: job['title'],email: job['user']?['email'],price: '\$${job['price']}',));
                  },
                ),
                SizedBox(height: 3.h),
                CustomButton(
                  title: 'Back to Jobs',
                  onPressed: () {},
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
