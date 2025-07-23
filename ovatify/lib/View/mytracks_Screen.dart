import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../data/apiHelper.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'List_Tracker_Screen.dart';
import 'home_Screen.dart';
import 'main_Screen.dart';

class MytracksScreen extends StatefulWidget {
  @override
  _MytracksScreenState createState() => _MytracksScreenState();
}

class _MytracksScreenState extends State<MytracksScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  String selectedChip = 'All Tracks';
  List<dynamic> projectList = [];
  bool isLoading = true;

  final List<String> chipLabels = ['All Tracks', 'Created by Me', 'Purchased', 'Bundles'];

  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(initialIndex: index),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTracks();
  }

  Future<void> fetchTracks() async {
    try {
      final response = await ApiService.get('music/creation?page=1');
      final decoded = json.decode(response.body);
      if (decoded['success'] == true) {
        setState(() {
          projectList = decoded['data'] ?? [];
        });
      }
    } catch (e) {
      print('Error fetching tracks: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchTrackById(String id) async {
    try {
      final response = await ApiService.get('music/creation/show/$id');
      final decoded = json.decode(response.body);
      if (decoded['success'] == true && decoded['data'] != null) {
        print("Track Details: ${decoded['data']}");
        // Optionally show details in a dialog or navigate to a new screen
      }
    } catch (e) {
      print('Error fetching track by ID: $e');
    }
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
                          text: 'Explore',
                          color: AppColors.magenta,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        ),
                        CustomLabelText(
                          text: 'Your Tracks',
                          color: AppColors.white,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        )
                      ],
                    )),
                SizedBox(height: 2.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: chipLabels.map((label) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          label,
                          style: TextStyle(
                            color: selectedChip == label ? Colors.white : AppColors.primary,
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
                    )).toList(),
                  ),
                ),
                SizedBox(height: 2.h),
                isLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.primary))
                    : projectList.isEmpty
                    ? Center(
                  child: CustomLabelText(
                    text: "No tracks found.",
                    color: AppColors.white,
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: projectList.length,
                  itemBuilder: (context, index) {
                    final item = projectList[index];
                    final isCompleted = (item["status"] ?? '').toString().toLowerCase() == "completed";
                    return InkWell(
                      onTap: () => fetchTrackById(item['id'].toString()),
                      child: Container(
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 1.7.h),
                                    CustomLabelText(
                                        text: item["title"] ?? 'No Title',
                                        color: Colors.white,
                                        fontSize: 16.sp),
                                    SizedBox(height: 1.7.h),
                                    CustomLabelText(
                                        text: item["blocks"] ?? 'Blocks Info',
                                        color: Colors.white,
                                        fontSize: 13.sp),
                                    SizedBox(height: 0.7.h),
                                    Row(
                                      children: [
                                        CustomLabelText(
                                          text: item["duration"] ?? '00:00',
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                        SizedBox(width: 2.7.w),
                                        CustomLabelText(
                                          text: item["status"] ?? 'Draft',
                                          color: AppColors.magenta,
                                          fontSize: 14.sp,
                                        ),
                                        if (isCompleted) ...[
                                          SizedBox(width: 4.w),
                                          Image.asset(AppImages.download, scale: 0.9),
                                        ]
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
                      ),
                    );
                  },
                ),
                SizedBox(height: 3.h),
                CustomLabelText(
                  text: 'Want to reach more listeners?',
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 2.h),
                CustomButton(
                  title: 'List your track on QmeMarketplace',
                  fontsize: 16.sp,
                  borderwidth: 0.51,
                  borderRadius: 15.sp,
                  backgroundColor: AppColors.black,
                  borderColor: AppColors.white,
                  onPressed: () {
                    Get.to(() => ListTrackerScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
